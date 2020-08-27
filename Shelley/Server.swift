//
//  Server.swift
//  Shelley
//
//  Created by Tyler Hall on 8/26/20.
//  Copyright © 2020 Tyler Hall. All rights reserved.
//

import Foundation

class Server {

    static let shared = Server()

    let HTTPServer = CRHTTPServer()
    
    var taskRunners = Set<TaskRunner>()

    func start() {
        HTTPServer.options(nil) { (request, response, next) in
            response.setAllHTTPHeaderFields(["Access-Control-Allow-Origin": "*", "Access-Control-Allow-Methods": "POST, OPTIONS"])
            response.send("")
        }

        HTTPServer.get(nil) { [weak self] (request, response, next) in
            guard let self = self else { return }

            let components = request.url.pathComponents
            guard components.count >= 3 else {
                response.send("Invalid command: " + UUID().uuidString)
                return
            }

            guard self.keyIsValid(request: request) else {
                response.send("Invalid key: " + UUID().uuidString)
                return
            }

            let command = components[1].lowercased()
            let scriptName = components[2]
            
            if !["run", "wait"].contains(command) {
                response.send("Invalid command: " + UUID().uuidString)
                return
            }

            if scriptName.count > 0, let runner = TaskRunner(scriptName: scriptName) {
                if command == "run" {
                    runner.execute()
                    response.send("OK: " + UUID().uuidString)
                } else if command == "wait" {
                    runner.execute {
                        response.send("OK: " + UUID().uuidString)
                    }
                }
            } else {
                response.send("Script does not exist: " + UUID().uuidString)
            }
        }

        HTTPServer.startListening(nil, portNumber: UInt(9876))
    }
    
    func keyIsValid(request: CRRequest) -> Bool {
        if let headerKey = request.allHTTPHeaderFields["key"] {
            return headerKey == Constants.key
        }
        return request.url.lastPathComponent == Constants.key
    }
}

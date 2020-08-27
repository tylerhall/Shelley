//
//  TaskRunner.swift
//  Shelley
//
//  Created by Tyler Hall on 8/26/20.
//  Copyright © 2020 Tyler Hall. All rights reserved.
//

import Foundation

class TaskRunner {

    var scriptURL: URL

    let uuid = UUID().uuidString

    init?(scriptName: String) {
        guard let url = Constants.scriptFolderURL?.appendingPathComponent(scriptName).appendingPathExtension("sh") else { return nil }
        if FileManager.default.isExecutableFile(atPath: url.path) {
            scriptURL = url
        } else {
            return nil
        }
    }

    func execute(_ completion: (() -> ())? = nil) {
        let sh = Process()
        sh.launchPath = scriptURL.path

        DispatchQueue.global(qos: .userInitiated).async {
            sh.launch()
            sh.waitUntilExit()
            completion?()
        }
    }
}

extension TaskRunner: Equatable {
    static func == (lhs: TaskRunner, rhs: TaskRunner) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}

extension TaskRunner: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}

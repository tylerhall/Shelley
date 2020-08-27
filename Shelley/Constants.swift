//
//  Constants.swift
//  Shelley
//
//  Created by Tyler Hall on 8/26/20.
//  Copyright © 2020 Tyler Hall. All rights reserved.
//

import Foundation

class Constants {

    static let kLaunchCount = "kLaunchCount"

    static var scriptFolderURL: URL? {
        get {
            if let url = UserDefaults.standard.url(forKey: "scriptFolderURL") {
                return url
            }
            return URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Shelley")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "scriptFolderURL")
            UserDefaults.standard.synchronize()
        }
    }

    static var key: String? {
        guard let scriptFolderURL = scriptFolderURL else { return nil }
        if FileManager.default.fileExists(atPath: scriptFolderURL.path) {
            let keyURL = scriptFolderURL.appendingPathComponent("key").appendingPathExtension("txt")
            if FileManager.default.fileExists(atPath: keyURL.path) {
                return try? String(contentsOf: keyURL)
            } else {
                let key = UUID().uuidString
                do {
                    try key.write(to: keyURL, atomically: true, encoding: .utf8)
                    return key
                } catch {
                    return nil
                }
            }
        } else {
            return nil
        }
    }
}

//
//  AboutWindowController.swift
//  CommandQ
//
//  Created by Tyler Hall on 6/21/19.
//  Copyright © 2019 Click On Tyler. All rights reserved.
//

import Cocoa

class AboutWindowController: NSWindowController {
    
    @IBOutlet weak var versionTextField: NSTextField!

    override func windowDidLoad() {
        super.windowDidLoad()

        window?.isMovableByWindowBackground = true
        window?.tabbingMode = .disallowed

        if let versionStr = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") {
            versionTextField.stringValue = "Version \(versionStr)"
            #if MAS
            versionTextField.stringValue = versionTextField.stringValue + " Mac App Store"
            #endif
        }
    }
}

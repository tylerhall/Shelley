//
//  PrefsWindowController.swift
//  Jigsaw
//
//  Created by Tyler Hall on 8/2/20.
//  Copyright © 2020 Tyler Hall. All rights reserved.
//

import Cocoa

class PrefsWindowController: NSWindowController {
    
    @IBOutlet weak var pathControl: NSPathControl!

    override func windowDidLoad() {
        super.windowDidLoad()
        pathControl.allowedTypes = ["public.folder"]
        updateUI()
    }
    
    func updateUI() {
        pathControl.url = Constants.scriptFolderURL
    }

    @IBAction func coffee(_ sender: AnyObject?) {
        NSWorkspace.shared.open(URL(string: "https://www.buymeacoffee.com/tylerhall")!)
    }

    @IBAction func chooseScriptFolder(_ sender: AnyObject?) {
        Constants.scriptFolderURL = pathControl.url
        updateUI()
    }
    
    @IBAction func openHelp(_ sender: AnyObject?) {
        NSWorkspace.shared.open(URL(string: "https://github.com/tylerhall/Shelley")!)
    }
}

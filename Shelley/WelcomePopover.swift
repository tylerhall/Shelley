//
//  SpotifyNotRunningViewController.swift
//  Spotish
//
//  Created by Tyler Hall on 3/24/20.
//  Copyright © 2020 Your Company. All rights reserved.
//

import Cocoa

class WelcomePopover: NSViewController {
    
    var shouldDismiss: (() -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func openPrefs(_ sender: AnyObject?) {
        if let ad = NSApp.delegate as? AppDelegate {
            ad.showPrefs(sender)
        }
        shouldDismiss?()
    }
}

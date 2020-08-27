//
//  AppDelegate.swift
//  Shelley
//
//  Created by Tyler Hall on 8/26/20.
//  Copyright © 2020 Tyler Hall. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var statusBarMenu: NSMenu!

    lazy var prefsWindowController: PrefsWindowController = { PrefsWindowController(windowNibName: String(describing: PrefsWindowController.self)) }()
    lazy var aboutWindowController: AboutWindowController = { AboutWindowController(windowNibName: String(describing: AboutWindowController.self)) }()

    let statusItem = MenuBarStatusItem()
    let statusItemPopover = NSPopover()
    lazy var welcomeViewController: WelcomePopover = { WelcomePopover(nibName: String(describing: WelcomePopover.self), bundle: nil) }()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        registerDefaults()
        
        statusItem.setImageNamed("Menubar")
        statusItem.setMenu(statusBarMenu)
        
        incrementLaunchCount()
        if launchCount() == 1 {
            showWelcomePopover(nil)
        }

        Server.shared.start()
    }

    func registerDefaults() {
        if let defaultsPath = Bundle.main.path(forResource: "Defaults", ofType: "plist") {
            if let defaults = NSDictionary(contentsOfFile: defaultsPath) as? [String: Any] {
                UserDefaults.standard.register(defaults: defaults)
            }
        }
    }

    func incrementLaunchCount() {
        let launchInt = launchCount() + 1

        let launchNumber = NSNumber(value: launchInt)
        UserDefaults.standard.setValue(launchNumber, forKey: Constants.kLaunchCount)
        UserDefaults.standard.synchronize()
    }
    
    func launchCount() -> Int {
        if let launchNumber = UserDefaults.standard.value(forKey: Constants.kLaunchCount) as? NSNumber {
            return launchNumber.intValue
        } else {
            return 0
        }
    }
}

extension AppDelegate {
    
    @IBAction func showPrefs(_ sender: AnyObject?) {
        prefsWindowController.showWindow(sender)
        prefsWindowController.window?.makeKeyAndOrderFront(sender)
        NSApp.activate(ignoringOtherApps: true)
    }

    @IBAction func showAbout(_ sender: AnyObject?) {
        aboutWindowController.showWindow(nil)
        aboutWindowController.window?.makeKeyAndOrderFront(sender)
        aboutWindowController.window?.center()
        NSApp.activate(ignoringOtherApps: true)
    }

    @IBAction func checkForUpdates(_ sender: AnyObject?) {
        SUUpdater.shared()?.checkForUpdates(nil)
    }

    @IBAction func quit(_ sender: AnyObject?) {
        NSApp.terminate(nil)
    }

    @IBAction func showWelcomePopover(_ sender: AnyObject?) {
        statusItemPopover.behavior = .applicationDefined
        statusItemPopover.contentViewController = welcomeViewController
        statusItemPopover.show(relativeTo: .zero, of: (statusItem.statusItem?.button)!, preferredEdge: .minY)
        welcomeViewController.shouldDismiss = { [weak self] in
            self?.statusItemPopover.close()
        }
    }
    
    @IBAction func otherApps(_ sender: AnyObject?) {
        NSWorkspace.shared.open(URL(string: "https://clickontyler.com")!)
    }
}

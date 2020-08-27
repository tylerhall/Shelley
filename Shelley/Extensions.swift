//
//  Extensions.swift
//  Shelley
//
//  Created by Tyler Hall on 8/26/20.
//  Copyright © 2020 Tyler Hall. All rights reserved.
//

import AppKit

extension NSEvent {
    var isRightClick: Bool {
        let rightClick = (self.type == .rightMouseDown)
        let controlClick = self.modifierFlags.contains(.control)
        return rightClick || controlClick
    }
}

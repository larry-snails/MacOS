//
//  AppDelegate.swift
//  macos_searchTextField_learn
//
//  Created by 吕志滨 on 2019/7/26.
//  Copyright © 2019 吕志滨. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let rawValue = NSWindow.StyleMask.titled.rawValue | NSWindow.StyleMask.closable.rawValue | NSWindow.StyleMask.miniaturizable.rawValue | NSWindow.StyleMask.resizable.rawValue
        window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 600, height: 400), styleMask: NSWindow.StyleMask(rawValue: rawValue), backing: NSWindow.BackingStoreType.buffered, defer: true)
        window.makeKeyAndOrderFront(nil)
        window.center()
        initUI()
    }

    func initUI() {
        let searchTextField = NSSearchField()
        searchTextField.frame = NSRect(origin: CGPoint.zero, size: CGSize(width: 200, height: 100))

        let cell = MySearchCell()
        searchTextField.cell = cell
        window.contentView?.addSubview(searchTextField)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}


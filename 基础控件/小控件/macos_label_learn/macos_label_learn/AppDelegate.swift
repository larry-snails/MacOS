//
//  AppDelegate.swift
//  macos_label_learn
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
        initLabels()
    }

    func initLabels() {
        let label1 = NSTextField()
        let attr1 = NSMutableAttributedString(string: "attributedStringValue")
        attr1.addAttributes([NSAttributedString.Key.foregroundColor: NSColor.red], range: NSRange(location: 0, length: 3))
        attr1.addAttributes([NSAttributedString.Key.font: NSFont.systemFont(ofSize: 30)], range: NSRange(location: 0, length: 3))
        attr1.addAttributes([NSAttributedString.Key.foregroundColor: NSColor.orange], range: NSRange(location: 5, length: 5))
        attr1.addAttributes([NSAttributedString.Key.font: NSFont.systemFont(ofSize: 15)], range: NSRange(location: 5, length: 5))
        label1.attributedStringValue = attr1
        label1.frame = NSRect(x: 100, y: 100, width: 150, height: 50)
        window.contentView?.addSubview(label1)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}


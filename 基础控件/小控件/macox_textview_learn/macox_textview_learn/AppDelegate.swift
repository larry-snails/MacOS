//
//  AppDelegate.swift
//  macox_textview_learn
//
//  Created by 吕志滨 on 2019/7/26.
//  Copyright © 2019 吕志滨. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate, NSTextViewDelegate {

    var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let rawValue = NSWindow.StyleMask.titled.rawValue | NSWindow.StyleMask.closable.rawValue | NSWindow.StyleMask.miniaturizable.rawValue | NSWindow.StyleMask.resizable.rawValue
        window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 600, height: 400), styleMask: NSWindow.StyleMask(rawValue: rawValue), backing: NSWindow.BackingStoreType.buffered, defer: true)
        window.makeKeyAndOrderFront(nil)
        window.center()
        initUI()
    }

    func initUI() {
        let textView = NSTextView(frame: NSRect(x: 100, y: 50, width: 400, height: 300))
        textView.font = NSFont.systemFont(ofSize: 20)
        textView.textColor = NSColor.green
        textView.backgroundColor = NSColor.orange
        textView.isEditable = true
        textView.isSelectable = true
        textView.delegate = self
        window.contentView?.addSubview(textView)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func textShouldEndEditing(_ textObject: NSText) -> Bool {
        print("textShouldEndEditing")
        return true
    }

    func textShouldBeginEditing(_ textObject: NSText) -> Bool {
        print("textShouldBeginEditing")
        return true
    }

    func textDidBeginEditing(_ notification: Notification) {
        print("textDidBeginEditing")
    }

    func textDidEndEditing(_ notification: Notification) {
        print("textDidEndEditing")
    }

    func textDidChange(_ notification: Notification) {
        print("textDidChange")
    }
}



//
//  AppDelegate.swift
//  macos_responseList_learn
//
//  Created by 吕志滨 on 2019/7/26.
//  Copyright © 2019 吕志滨. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    var window: MyWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let rawValue = NSWindow.StyleMask.titled.rawValue | NSWindow.StyleMask.closable.rawValue | NSWindow.StyleMask.miniaturizable.rawValue | NSWindow.StyleMask.resizable.rawValue
        window = MyWindow(contentRect: NSRect(x: 0, y: 0, width: 600, height: 400), styleMask: NSWindow.StyleMask(rawValue: rawValue), backing: NSWindow.BackingStoreType.buffered, defer: true)
        window.makeKeyAndOrderFront(nil)
        window.center()
        initUI()
    }

    func initUI() {

        // 响应者链，详情可搜索一下iOS响应者链，从下到上，在从上到下
        let view = MyView(frame: NSRect(x: 0, y: 0, width: 600, height: 400))
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.systemPink.cgColor

        let button = MyButton()
        button.frame = NSRect(x: 100, y: 100, width: 200, height: 200)
        button.title = "button"
        view.addSubview(button)

        window.contentView?.addSubview(view)

    }

    

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}


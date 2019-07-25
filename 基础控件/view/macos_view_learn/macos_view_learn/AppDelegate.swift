//
//  AppDelegate.swift
//  macos_view_learn
//
//  Created by 吕志滨 on 2019/7/25.
//  Copyright © 2019 吕志滨. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    var myView: MyView!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let rawValue = NSWindow.StyleMask.titled.rawValue | NSWindow.StyleMask.closable.rawValue | NSWindow.StyleMask.miniaturizable.rawValue | NSWindow.StyleMask.resizable.rawValue
        window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 600, height: 400), styleMask: NSWindow.StyleMask(rawValue: rawValue), backing: NSWindow.BackingStoreType.buffered, defer: true)
        window.orderFront(nil)
        window.center()
        addView()
        coverPoint()
    }

    func addView() {
        myView = MyView()
        myView.frame = NSRect(x: 100, y: 100, width: 400, height: 200)
        myView.wantsLayer = true
        myView.layer?.backgroundColor = NSColor.red.cgColor
        window.contentView?.addSubview(myView)
    }

    func coverPoint() {
        let point = CGPoint(x: 150, y: 150)
        let myViewPoint = myView.convert(point, from: window.contentView!)
        let str1 = "在window的contentView中的位置是x:\(point.x)  y:\(point.y),对应的在红色试图中的坐标是x:\(myViewPoint.x)  y:\(myViewPoint.y)"

        let label1 = NSTextField(frame: NSRect(x: 100, y: 20, width: 200, height: 70))
        label1.stringValue = str1
        label1.alignment = .center
        myView.addSubview(label1)

        let windowPoint = myView.convert(point, to: window.contentView!)
        let str2 = "在红色试图中的位置是x:\(point.x) y:\(point.y),对应的在windowc的contentView中的坐标是x:\(windowPoint.x)  y:\(windowPoint.y)"
        let label2 = NSTextField(frame: NSRect(x: 100, y: 120, width: 200, height: 70))
        label2.stringValue = str2
        label2.alignment = .center
        myView.addSubview(label2)

    }

    func applicationWillTerminate(_ aNotification: Notification) {

    }


}


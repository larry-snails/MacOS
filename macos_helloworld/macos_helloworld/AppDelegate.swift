//
//  AppDelegate.swift
//  macos_helloworld
//
//  Created by 吕志滨 on 2019/7/25.
//  Copyright © 2019 吕志滨. All rights reserved.
//

import Cocoa

/*
    由于个人原因，不太喜欢图形化编程，但是macos程序会默认会创建xib和storyboard，下面介绍图形化编程改纯代码
        1.删除MainMenu.xib或者main.storebold
        2.删除AppDelegate 里面的@NSApplicationMain
        3.删除infoPlist里面的Main nib file base name 或者 Main storyboard file base name
        4.创建main.swift
        5.在applicationDidFinishLaunching中创建window和试图
        6.自己创建的ViewController 一定要重写loadView方法，macos 和iOS程序不一样，不会自动z装载试图
 */
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let rawValue = NSWindow.StyleMask.titled.rawValue | NSWindow.StyleMask.closable.rawValue | NSWindow.StyleMask.miniaturizable.rawValue
        //创建window
        window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 600, height: 400), styleMask: NSWindow.StyleMask(rawValue: rawValue), backing: NSWindow.BackingStoreType.buffered, defer: true)
        // 设置window 的 contentViewController
        window.contentViewController = ViewController()
        // 显示window
        window.makeKeyAndOrderFront(nil)
        window.center()

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}


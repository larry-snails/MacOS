//
//  AppDelegate.swift
//  macos_OutlineView_learn
//
//  Created by 吕志滨 on 2019/7/29.
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
        initMunu()
    }

    func initUI() {
        let outlineView = NSOutlineView(frame: NSRect(x: 50, y: 50, width: 500, height: 300))
        outlineView.delegate = self
        outlineView.dataSource = self
        //允许自动调节大小
        outlineView.allowsColumnResizing = true
        //背景颜色交替
        outlineView.usesAlternatingRowBackgroundColors = true
        outlineView.headerView = nil
        outlineView.columnAutoresizingStyle = .firstColumnOnlyAutoresizingStyle
        let column = NSTableColumn()
        outlineView.addTableColumn(column)

        let scrollView = NSScrollView()
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = true
        scrollView.autohidesScrollers = true
        self.window.contentView?.addSubview(scrollView)

    }

    func initMunu() {
        var mainMenu = NSApp.mainMenu
        if mainMenu == nil {
            mainMenu = NSMenu(title: "main menu")
            mainMenu?.title = "主菜单"
        }

        let mainMenuItem = NSMenuItem(title: "主菜单", action: nil, keyEquivalent: "a")
        mainMenuItem.title = "主菜单"
        mainMenu?.addItem(mainMenuItem)
//        mainMenu?.insertItem(mainMenuItem, at: 2)

        let oneMenu = NSMenu(title: "一级目录1")
        mainMenuItem.submenu = oneMenu

        let oneMenuItem = NSMenuItem(title: "二级菜单1", action: nil, keyEquivalent: "w")
        let twoMenuItem = NSMenuItem(title: "二级菜单2", action: nil, keyEquivalent: "e")
        let threeMenuItem = NSMenuItem(title: "二级菜单3", action: nil, keyEquivalent: "r")
        oneMenu.addItem(oneMenuItem)
        oneMenu.addItem(twoMenuItem)
        oneMenu.addItem(threeMenuItem)

        let twoItem = NSMenuItem(title: "View", action: nil, keyEquivalent: "b")
        mainMenu?.addItem(twoItem)

        NSApp.mainMenu = mainMenu
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

extension AppDelegate: NSOutlineViewDelegate, NSOutlineViewDataSource {

}


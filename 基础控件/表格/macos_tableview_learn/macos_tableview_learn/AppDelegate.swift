//
//  AppDelegate.swift
//  macos_tableview_learn
//
//  Created by 吕志滨 on 2019/7/29.
//  Copyright © 2019 吕志滨. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    var datas = [["name": "Tom", "age": "108", "city": "ttt", "country": "USA"],
                 ["name": "Tom", "age": "108", "city": "ttt", "country": "USA"],
                 ["name": "Tom", "age": "108", "city": "ttt", "country": "USA"],
                 ["name": "Tom", "age": "108", "city": "ttt", "country": "USA"],
                 ["name": "Tom", "age": "108", "city": "ttt", "country": "USA"],
                 ["name": "Tom", "age": "108", "city": "ttt", "country": "USA"],
                 ["name": "Tom", "age": "108", "city": "ttt", "country": "USA"],
                 ["name": "Tom", "age": "108", "city": "ttt", "country": "USA"],
                 ["name": "Tom", "age": "108", "city": "ttt", "country": "USA"],
                 ["name": "Tom", "age": "108", "city": "ttt", "country": "USA"],
                 ["name": "Tom", "age": "108", "city": "ttt", "country": "USA"],
                 ["name": "Tom", "age": "108", "city": "ttt", "country": "USA"],
                 ["name": "Tom", "age": "108", "city": "ttt", "country": "USA"],
                 ["name": "Tom", "age": "108", "city": "ttt", "country": "USA"],
                 ["name": "Tom", "age": "108", "city": "ttt", "country": "USA"]]


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let rawValue = NSWindow.StyleMask.titled.rawValue | NSWindow.StyleMask.closable.rawValue | NSWindow.StyleMask.miniaturizable.rawValue | NSWindow.StyleMask.resizable.rawValue
        window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 600, height: 400), styleMask: NSWindow.StyleMask(rawValue: rawValue), backing: NSWindow.BackingStoreType.buffered, defer: true)
        window.makeKeyAndOrderFront(nil)
        window.center()
        initTable()
    }

    func initTable() {
        let table = NSTableView(frame: NSRect(x: 0, y: 0, width: 600, height: 400))
        table.delegate = self
        table.dataSource = self

        let column1 = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "name"))
        column1.title = "Name"
        column1.width = 150
        table.addTableColumn(column1)

        let column2 = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "age"))
        column2.title = "Age"
        column2.width = 150
        table.addTableColumn(column2)

        let column3 = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "city"))
        column3.title = "City"
        column3.width = 150
        table.addTableColumn(column3)

        let column4 = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "country"))
        column4.title = "Country"
        column4.width = 150
        table.addTableColumn(column4)

        /// 行与行之间变换颜色
        table.usesAlternatingRowBackgroundColors = true
        table.backgroundColor = NSColor.yellow
        table.wantsLayer = true
        //行高亮风格
        table.selectionHighlightStyle = .none
        //获得焦点的风格
        table.focusRingType = .none

        let scrollView = NSScrollView(frame: NSRect(x: 0, y: 0, width: 600, height: 400))
        scrollView.backgroundColor = .red
        scrollView.documentView = table
        scrollView.hasHorizontalScroller = true
        scrollView.hasVerticalRuler = true
        scrollView.autohidesScrollers = true
        scrollView.drawsBackground = true
        self.window.contentView?.addSubview(scrollView)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

extension AppDelegate: NSTableViewDelegate, NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.datas.count
    }

    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {

        guard let identify = tableColumn?.identifier.rawValue else {
            return nil
        }

        var cellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: identify), owner: self)
        if cellView == nil {
            cellView = NSView()
            cellView?.identifier = NSUserInterfaceItemIdentifier(rawValue: identify)
            cellView?.wantsLayer = true
            let textField = NSTextField()
            textField.frame = NSRect(x: 0, y: 0, width: 150, height: 50)
            textField.alignment = .center
            textField.isEnabled = false
            textField.tag = 10
            cellView?.addSubview(textField)
        }
        if let textField = cellView?.viewWithTag(10) as? NSTextField {
            let data = self.datas[row]
            let value = data[identify]
            textField.stringValue = value ?? identify
        }
        return cellView
    }
}


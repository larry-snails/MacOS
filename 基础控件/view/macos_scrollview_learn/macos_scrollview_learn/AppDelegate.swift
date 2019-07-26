//
//  AppDelegate.swift
//  macos_scrollview_learn
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
         addUI()
        window.makeKeyAndOrderFront(nil)
        window.center()

    }

    func addUI() {

        /* NSScrollView由NSScroller NSClipView contentView NSRulerView组成
         * NSClipView 负责截屏
         * NSScroller 是滚动条
         * contentView 负责承载内容 相当于UIScrollView 中的 contentSize
         * NSRulerView 标尺
         */

        let scrollView = MyScrollView(frame: window.contentView!.bounds)
        scrollView.scrollerStyle = .legacy

        //是否显示滚动条，需要手动设置为true，code创建的scrollview会默认为false
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = true

        //滚动回弹效果，相当于UIScrooView中的bounce属性
        scrollView.verticalScrollElasticity = .automatic
        scrollView.horizontalScrollElasticity = .automatic

        let documentView = NSView(frame: NSRect(x: 0, y: 0, width: 1000, height: 1200))
        documentView.wantsLayer = true

        //NSScrooView 中没有 contentSize,取而代之的是contentView
        scrollView.documentView = documentView
        let colors = [NSColor.red.cgColor, NSColor.yellow.cgColor, NSColor.blue.cgColor, NSColor.green.cgColor, NSColor.systemPink.cgColor, NSColor.orange.cgColor]
        for index in 0..<6 {
            let x = (index % 2) * 500
            let y = (index / 2) * 400
            let view = NSView(frame: NSRect(x: x, y: y, width: 500, height: 400))
            view.wantsLayer = true
            view.layer?.backgroundColor = colors[index]
            documentView.addSubview(view)
        }
        if documentView.isFlipped {
            documentView.scroll(.zero)
        } else {
            let maxHeight = max(scrollView.bounds.height, documentView.bounds.height)
            documentView.scroll(NSPoint(x: 0, y: maxHeight))
        }

        window.contentView?.addSubview(scrollView)

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}


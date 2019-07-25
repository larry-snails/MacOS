//
//  AppDelegate.swift
//  macos_window_learn
//
//  Created by 吕志滨 on 2019/7/25.
//  Copyright © 2019 吕志滨. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    var modalWindowController: MyWindowController?

    var sessionWindow: NSWindow?

    var sessionCode: NSApplication.ModalSession?

    var sessionWindowController: MyWindowController?

    var showWindowController: MyWindowController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        window = NSWindow(contentRect: NSRect(origin: CGPoint.zero, size: CGSize(width: 600, height: 600)), styleMask: NSWindow.StyleMask(rawValue: (NSWindow.StyleMask.titled.rawValue | NSWindow.StyleMask.closable.rawValue)), backing: NSWindow.BackingStoreType.buffered, defer: true)
        window.contentViewController = ViewController()
        window.makeKeyAndOrderFront(self)
        window.center()

        addKvo()
    }

    func addKvo() {
        NotificationCenter.default.addObserver(self, selector: #selector(windowClose(notification:)), name: NSWindow.willCloseNotification, object: nil)
    }

    @objc func windowClose(notification: Notification) {
        if let code = sessionCode {
            NSApplication.shared.endModalSession(code)
            sessionCode = nil
        } else if let modalWindow = notification.object as? NSWindow, modalWindow == modalWindowController?.window {
            NSApplication.shared.stopModal()
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func showModalWindow() {
        if modalWindowController == nil {
            let modalWindow = NSWindow(contentRect: NSRect(origin: CGPoint.zero, size: CGSize(width: 600, height: 600)), styleMask: NSWindow.StyleMask(rawValue: (NSWindow.StyleMask.titled.rawValue | NSWindow.StyleMask.closable.rawValue)), backing: NSWindow.BackingStoreType.buffered, defer: true)
            modalWindowController = MyWindowController.init(window: modalWindow)

        }

        if let modalWindow = modalWindowController?.window {
            modalWindow.title = "modal window"
            NSApplication.shared.runModal(for: modalWindow)
        }
    }

    func showSessionWindow() {
        if sessionWindow == nil {
            sessionWindow = NSWindow(contentRect: NSRect(origin: CGPoint.zero, size: CGSize(width: 600, height: 600)), styleMask: NSWindow.StyleMask(rawValue: (NSWindow.StyleMask.titled.rawValue | NSWindow.StyleMask.closable.rawValue)), backing: NSWindow.BackingStoreType.buffered, defer: true)
            if sessionWindowController == nil {
                //弹出一个window，必须把w这个window 绑定到windowController上，如果不绑定，就会被回收，下次用到时候回崩溃
                //注意： 即便是被注册成属性强引用，依然会被回收，引起崩溃
                sessionWindowController = MyWindowController.init(window: sessionWindow)
            }
        }
        sessionWindow?.title = "session window"
        sessionCode = NSApplication.shared.beginModalSession(for: sessionWindow!)
    }

    func showWindow() {
        if showWindowController == nil {
            let showWindow = NSWindow(contentRect: NSRect(origin: CGPoint.zero, size: CGSize(width: 600, height: 600)), styleMask: NSWindow.StyleMask(rawValue: (NSWindow.StyleMask.titled.rawValue | NSWindow.StyleMask.closable.rawValue)), backing: NSWindow.BackingStoreType.buffered, defer: true)
            showWindowController = MyWindowController.init(window: showWindow)
        }

        if let showWindow = showWindowController?.window {
            showWindow.title = "show window"
            showWindow.makeKeyAndOrderFront(self)
            showWindow.center()
        }
    }
}


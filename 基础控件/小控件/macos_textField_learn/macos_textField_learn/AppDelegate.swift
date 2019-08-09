//
//  AppDelegate.swift
//  macos_textField_learn
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
        let textField1 = MyTextField()
        textField1.textColor = NSColor.systemPink
        textField1.placeholderString = "请输入用户名"
        textField1.font = NSFont.systemFont(ofSize: 15)
        textField1.frame = CGRect(x: 100, y: 50, width: 150, height: 30)
        textField1.delegate = self

        let textField2 = NSSecureTextField()
        textField2.placeholderString = "请输入密码"
        textField2.frame = CGRect(x: 300, y: 50, width: 150, height: 30)
        textField2.delegate = self

        let textField3 = MyTextField()

        let textField4 = MyTextField()

        window.contentView?.addSubview(textField1)
        window.contentView?.addSubview(textField2)
        window.contentView?.addSubview(textField3)
        window.contentView?.addSubview(textField4)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }



}

extension AppDelegate: NSTextFieldDelegate {
    func control(_ control: NSControl, textShouldEndEditing fieldEditor: NSText) -> Bool {
        print("control textShouldEndEditing")
        return true
    }

    func controlTextDidEndEditing(_ obj: Notification) {
        print("controlTextDidEndEditing")
    }

    func control(_ control: NSControl, textShouldBeginEditing fieldEditor: NSText) -> Bool {
        print("control textShouldBeginEditing")
        return true
    }

    func controlTextDidBeginEditing(_ obj: Notification) {
        print("controlTextDidBeginEditing")
    }

    func controlTextDidChange(_ obj: Notification) {
        print("controlTextDidChange")
    }



}


class MyTextField: NSTextField {
    open override func draw(withExpansionFrame contentFrame: NSRect, in view: NSView) {
        let rect = self.adjustedFrameToVerticallyCenterText(rect: contentFrame)
        super.draw(withExpansionFrame: rect, in: view)
    }

    open override func edit(withFrame rect: NSRect, editor textObj: NSText, delegate: Any?, event: NSEvent) {
        super.edit(withFrame: self.adjustedFrameToVerticallyCenterText(rect: rect), editor: textObj, delegate: delegate, event: event)
    }

    open override func select(withFrame rect: NSRect, editor textObj: NSText, delegate: Any?, start selStart: Int, length selLength: Int) {
        super.select(withFrame: self.adjustedFrameToVerticallyCenterText(rect: rect), editor: textObj, delegate: delegate, start: selStart, length: selLength)
    }

    func adjustedFrameToVerticallyCenterText(rect: NSRect) -> NSRect {
        guard let textFont = self.font else {
            return rect
        }
        let offSet = floor(NSHeight(rect)/2 - textFont.ascender - textFont.descender)
        return NSInsetRect(rect, 0.0, offSet)
    }
}

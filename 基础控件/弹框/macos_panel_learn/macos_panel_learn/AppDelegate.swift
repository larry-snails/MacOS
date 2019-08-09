//
//  AppDelegate.swift
//  macos_panel_learn
//
//  Created by 吕志滨 on 2019/7/26.
//  Copyright © 2019 吕志滨. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    var panel: NSPanel!

    var openPanel: NSOpenPanel!

    var savePanel: NSSavePanel!

    var colorPanel: NSColorPanel!

    var fontPanel: NSFontManager!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let rawValue = NSWindow.StyleMask.titled.rawValue | NSWindow.StyleMask.closable.rawValue | NSWindow.StyleMask.miniaturizable.rawValue | NSWindow.StyleMask.resizable.rawValue
        window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 600, height: 400), styleMask: NSWindow.StyleMask(rawValue: rawValue), backing: NSWindow.BackingStoreType.buffered, defer: true)
        window.makeKeyAndOrderFront(nil)
        window.center()
        initUI()
    }

    func initUI() {
        initPanel()
        initOpenPanel()
        initSavePanel()
        initColorPanel()
        initFontPanel()
        let panelButton = NSButton(frame: NSRect(x: 100, y: 100, width: 100, height: 50))
        panelButton.title = "panel"
        panelButton.target = self
        panelButton.action = #selector(panelButtonClick)
        window.contentView?.addSubview(panelButton)

        let openButton = NSButton(frame: NSRect(x: 100, y: 200, width: 100, height: 50))
        openButton.title = "open"
        openButton.target = self
        openButton.action = #selector(openButtonClick)
        window.contentView?.addSubview(openButton)

        let saveButton = NSButton(frame: NSRect(x: 100, y: 300, width: 100, height: 50))
        saveButton.title = "save"
        saveButton.target = self
        saveButton.action = #selector(saveButtonClick)
        window.contentView?.addSubview(saveButton)

        let colorButton = NSButton(frame: NSRect(x: 300, y: 100, width: 100, height: 50))
        colorButton.title = "color"
        colorButton.target = self
        colorButton.action = #selector(choseColor)
        window.contentView?.addSubview(colorButton)

        let fontButton = NSButton(frame: NSRect(x: 300, y: 200, width: 100, height: 50))
        fontButton.title = "font"
        fontButton.target = self
        fontButton.action = #selector(fontChose)
        window.contentView?.addSubview(fontButton)
    }

    func initColorPanel() {
        colorPanel = NSColorPanel()
        colorPanel.setTarget(self)
        colorPanel.setAction(#selector(colorDidChose(_:)))
    }

    @objc func colorDidChose(_ panel: NSColorPanel) {
        let color = panel.color as NSColor
        print(color)
    }

    func initFontPanel() {
        fontPanel = NSFontManager.shared
        fontPanel.target = self
        fontPanel.action = #selector(fontDidChose(_:))
    }

    @objc func fontDidChose(_ sender: NSFontManager) {
        var font = NSFont.systemFont(ofSize: 10)
        font = sender.convert(font)
        print(font)
    }

    func changeFont(_ sender: Any) {

    }

    func initOpenPanel() {
        openPanel = NSOpenPanel()
        openPanel.canChooseFiles = true
        openPanel.canChooseDirectories = true
        openPanel.allowsMultipleSelection = false
        openPanel.title = "请选择文件"
        openPanel.allowedFileTypes = ["txt", "png", "avi", "jpeg", "jpg"]
    }

    func initSavePanel() {
        savePanel = NSSavePanel()
        savePanel.title = "saveTitle"
        savePanel.allowedFileTypes = ["txt"]
        savePanel.message = "save your file"
        savePanel.nameFieldStringValue = "my"
    }

    func initPanel() {
        let rawValue = NSWindow.StyleMask.titled.rawValue | NSWindow.StyleMask.closable.rawValue | NSWindow.StyleMask.miniaturizable.rawValue | NSWindow.StyleMask.resizable.rawValue
        panel = NSPanel(contentRect: NSRect(x: 0, y: 0, width: 300, height: 200), styleMask: NSWindow.StyleMask(rawValue: rawValue), backing: NSWindow.BackingStoreType.buffered, defer: true)
        panel.title = "login view"
        panel.hasShadow = true
        panel.isRestorable = true
        panel.styleMask = .hudWindow

        let closeBtn = NSButton()
        closeBtn.title = "close"
        closeBtn.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        panel.contentView?.addSubview(closeBtn)
        closeBtn.target = self
        closeBtn.action = #selector(closeButtonClick)
    }

    @objc func closeButtonClick() {
        self.window.endSheet(panel)
    }

    @objc func panelButtonClick() {
        self.window.beginSheet(panel) { (_) in
            print("panel close")
        }
    }

    @objc func openButtonClick() {
        openPanel.begin { (result) in
            if result == .cancel {
                print("点击了取消")
            } else if result == .OK {
                print(self.openPanel.urls)
            }
        }
    }

    @objc func saveButtonClick() {

        savePanel.begin { (response) in
            if response == .OK {
                guard let path = self.savePanel.url else {
                    return
                }
                self.saveFile(to: path)
            } else {
                print("取消按钮点击")
            }
        }
    }

    func saveFile(to path: URL) {
        do {
            try path.absoluteString.write(toFile: path.absoluteString, atomically: true, encoding: .utf8)
        } catch let err as NSError {
            print(err)
        }
    }

    @objc func choseColor() {
        self.colorPanel.orderFront(nil)
    }

    @objc func fontChose() {
        self.fontPanel.orderFrontFontPanel(self)
    }


    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}


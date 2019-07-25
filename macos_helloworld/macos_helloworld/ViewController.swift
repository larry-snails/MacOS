//
//  ViewController.swift
//  macos_helloworld
//
//  Created by 吕志滨 on 2019/7/25.
//  Copyright © 2019 吕志滨. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func loadView() {
        let view = MyView(frame: NSRect(x: 0, y: 0, width: 600, height: 400))
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.white.cgColor
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }

    func initUI() {
        let textField = NSTextField(frame: NSRect(x: 200, y: 185, width: 200, height: 30))
        textField.isEnabled = false
        textField.stringValue = "Hello world"
        textField.isBordered = false
        textField.font = NSFont.systemFont(ofSize: 20)
        textField.alignment = NSTextAlignment.center
        textField.textColor = NSColor.red
        self.view.addSubview(textField)
    }
    
}

//
//  MainTableCellView.swift
//  macos_learn
//
//  Created by 吕志滨 on 2019/7/29.
//  Copyright © 2019 吕志滨. All rights reserved.
//

import Cocoa

class MainTableCellView: NSTableCellView {

    var label = NSTextField()

    init() {
        super.init(frame: NSRect.zero)
        initUI()
        self.wantsLayer = true
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initUI() {
        label.isEnabled = false
        label.textColor = NSColor.black
        label.alignment = .left
        label.font = NSFont.systemFont(ofSize: 15)
        label.frame = NSRect(x: 20, y: 15, width: 180, height: 20)
        label.wantsLayer = true
        label.isBordered = false
        label.backgroundColor = .clear
        self.addSubview(label)
    }

    func showData(str: String) {
        print(str)
        self.label.stringValue = str
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
}

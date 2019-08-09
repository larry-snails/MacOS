//
//  BaseView.swift
//  macos_learn
//
//  Created by 吕志滨 on 2019/8/8.
//  Copyright © 2019 吕志滨. All rights reserved.
//

import Cocoa

class BaseView: NSView {

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.wantsLayer = true
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var isFlipped: Bool {
        return true
    }
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}

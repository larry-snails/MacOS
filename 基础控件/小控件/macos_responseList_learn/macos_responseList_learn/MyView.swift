//
//  MyView.swift
//  macos_responseList_learn
//
//  Created by 吕志滨 on 2019/7/26.
//  Copyright © 2019 吕志滨. All rights reserved.
//

import Cocoa

class MyView: NSView {
    override var isFlipped: Bool {
        return true
    }

    override func scrollWheel(with event: NSEvent) {
        print("view scrollWheel")
        super.scrollWheel(with: event)
    }

    override func touchesBegan(with event: NSEvent) {
        print("view touchesBegan")
        touchesBegan(with: event)
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}

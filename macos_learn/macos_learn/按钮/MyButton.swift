//
//  MyButton.swift
//  macos_learn
//
//  Created by 吕志滨 on 2019/7/30.
//  Copyright © 2019 吕志滨. All rights reserved.
//

import Cocoa

class MyButton: NSButton {

    override func mouseEntered(with event: NSEvent) {
        print("mouseEntered")
    }

    override func mouseDown(with event: NSEvent) {
        print("mouseDown")
    }

    override func mouseUp(with event: NSEvent) {
        print("mouseUp")
    }

    override func mouseExited(with event: NSEvent) {
        print("mouseExited")
    }



    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}

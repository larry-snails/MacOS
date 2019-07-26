//
//  MyButton.swift
//  macos_responseList_learn
//
//  Created by 吕志滨 on 2019/7/26.
//  Copyright © 2019 吕志滨. All rights reserved.
//

import Cocoa

class MyButton: NSButton {

    override func scrollWheel(with event: NSEvent) {
        print("button scrollWheel")
        super.scrollWheel(with: event)
    }

    override func touchesBegan(with event: NSEvent) {
        print("button touchesBegan")
        touchesBegan(with: event)
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}

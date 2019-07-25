//
//  MyView.swift
//  macos_helloworld
//
//  Created by 吕志滨 on 2019/7/25.
//  Copyright © 2019 吕志滨. All rights reserved.
//

import Cocoa

class MyView: NSView {


    /// macos 原点默认为左下角，返回true，原点为左上角
    override var isFlipped: Bool {
        return true
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}

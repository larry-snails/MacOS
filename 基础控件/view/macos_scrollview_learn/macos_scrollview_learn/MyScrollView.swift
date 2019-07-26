//
//  MyScrollView.swift
//  macos_scrollview_learn
//
//  Created by 吕志滨 on 2019/7/26.
//  Copyright © 2019 吕志滨. All rights reserved.
//

import Cocoa

class MyScrollView: NSScrollView {

    override var isFlipped: Bool {
        return true
    }
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}

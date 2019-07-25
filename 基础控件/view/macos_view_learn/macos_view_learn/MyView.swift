//
//  MyView.swift
//  macos_view_learn
//
//  Created by 吕志滨 on 2019/7/25.
//  Copyright © 2019 吕志滨. All rights reserved.
//

import Cocoa

class MyView: NSView {

    override var isFlipped: Bool {
        return true
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        let rect = self.bounds
        let round = NSBezierPath(roundedRect: rect, xRadius: 10, yRadius: 10)
        round.lineWidth = 5
        NSColor.green.setStroke()
        round.stroke()
    }

    /// 试图将要添加到父试图
    ///
    /// - Parameter newSuperview: 父试图
    override func viewWillMove(toSuperview newSuperview: NSView?) {
        print("viewWillMovetoSuperview")
    }

    /// 试图已经添加到父试图
    override func viewDidMoveToSuperview() {
        print("viewDidMoveToSuperview")
    }

    /// 鼠标点击事件处理
    ///
    /// - Parameter event: 点击事件
    override func mouseDown(with event: NSEvent) {
        let point = self.convert(event.locationInWindow, from: nil)
        print(point)
    }


    /// 鼠标抬起事件
    ///
    /// - Parameter event: 事件
    override func mouseUp(with event: NSEvent) {
        super.mouseUp(with: event)
    }
    
}

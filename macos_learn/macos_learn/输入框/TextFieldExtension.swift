//
//  TextFieldExtension.swift
//  macos_learn
//
//  Created by 吕志滨 on 2019/7/31.
//  Copyright © 2019 吕志滨. All rights reserved.
//

import AppKit

class VerticalCenteredTextFieldCell: NSTextFieldCell {
    override func titleRect(forBounds rect: NSRect) -> NSRect {
        var rect = super.titleRect(forBounds: rect)
        rect.origin.y += (rect.height - cellSize.height) / 2
        return rect
    }

    override func drawInterior(withFrame cellFrame: NSRect, in controlView: NSView) {
        super.drawInterior(withFrame: titleRect(forBounds: cellFrame), in: controlView)
    }

    override func select(withFrame rect: NSRect, in controlView: NSView, editor textObj: NSText, delegate: Any?, start selStart: Int, length selLength: Int) {
        super.select(withFrame: titleRect(forBounds: rect), in: controlView, editor: textObj, delegate: delegate, start: selStart, length: selLength)
    }
}

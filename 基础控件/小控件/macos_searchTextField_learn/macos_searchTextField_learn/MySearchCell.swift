//
//  MySearchCell.swift
//  macos_searchTextField_learn
//
//  Created by 吕志滨 on 2019/7/26.
//  Copyright © 2019 吕志滨. All rights reserved.
//

import Cocoa

class MySearchCell: NSSearchFieldCell {

    override init(textCell string: String) {
        super.init(textCell: string)
        self.isEnabled = true
        self.isEditable = true
        setUp()
    }


    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUp() {
        let searchCell = NSButtonCell()
        searchCell.image = NSImage(named: NSImage.homeTemplateName)
        searchCell.image?.size = NSSize(width: 15, height: 15)
        self.searchButtonCell = searchCell

        let cancelCell = NSButtonCell()
        cancelCell.image = NSImage(named: NSImage.networkName)
        cancelCell.image?.size = NSSize(width: 15, height: 15)
        self.cancelButtonCell = cancelCell

    }

    override func drawInterior(withFrame cellFrame: NSRect, in controlView: NSView) {
        let rect = controlView.bounds
        let bezierPath = NSBezierPath(roundedRect: rect, xRadius: NSHeight(rect)/2, yRadius: NSHeight(rect)/2)
        NSColor.yellow.setFill()
        bezierPath.fill()
        super.drawInterior(withFrame: cellFrame, in: controlView)
    }



}

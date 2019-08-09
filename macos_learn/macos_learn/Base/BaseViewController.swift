//
//  BaseViewController.swift
//  macos_learn
//
//  Created by 吕志滨 on 2019/8/8.
//  Copyright © 2019 吕志滨. All rights reserved.
//

import Cocoa

class BaseViewController: NSViewController {

    override func loadView() {
        let size = NSApplication.shared.mainWindow?.frame.size ?? NSSize(width: 600, height: 400)
        let frame = NSRect(origin: CGPoint.zero, size: size)
        self.view = BaseView(frame: frame)
        view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.white.cgColor;
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}

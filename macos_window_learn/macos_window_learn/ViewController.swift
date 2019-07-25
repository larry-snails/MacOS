//
//  ViewController.swift
//  macos_window_learn
//
//  Created by 吕志滨 on 2019/7/25.
//  Copyright © 2019 吕志滨. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func loadView() {
        view = MyView(frame: NSRect(origin: CGPoint.zero, size: CGSize(width: 600, height: 600)))
        view.needsLayout = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }

    func initUI() {
        let modalWindow = NSButton(title: "modal window", target: self, action: #selector(modalWindowClick))
        modalWindow.frame = CGRect(x: 200, y: 100, width: 200, height: 50)
        self.view.addSubview(modalWindow)

        let sessionWindow = NSButton(title: "session window", target: self, action: #selector(sessionWindowClick))
        sessionWindow.frame = CGRect(x: 200, y: 300, width: 200, height: 50)
        self.view.addSubview(sessionWindow)

        let showWindow = NSButton(title: "show window", target: self, action: #selector(showWindowClick))
        showWindow.frame = CGRect(x: 200, y: 500, width: 200, height: 50)
        self.view.addSubview(showWindow)

    }

    @objc func modalWindowClick() {
        if let delegate = NSApplication.shared.delegate as? AppDelegate {
            delegate.showModalWindow()
        }
    }

    @objc func sessionWindowClick() {
        if let delegate = NSApplication.shared.delegate as? AppDelegate {
            delegate.showSessionWindow()
        }
    }

    @objc func showWindowClick() {
        if let delegate = NSApplication.shared.delegate as? AppDelegate {
            delegate.showWindow()
        }
    }
}

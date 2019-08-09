//
//  TestDismissController.swift
//  macos_learn
//
//  Created by 吕志滨 on 2019/8/8.
//  Copyright © 2019 吕志滨. All rights reserved.
//

import Cocoa
import Cartography

class TestDismissController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let dismissButton = NSButton(title: "dismiss", target: self, action: #selector(dismiss(button:)))
        dismissButton.frame = NSRect(x: 0, y: 0, width: 100, height: 50)
        self.view.addSubview(dismissButton)

        constrain(dismissButton) { (dismissButton) in
            dismissButton.centerX == dismissButton.superview!.centerX
            dismissButton.centerY == dismissButton.superview!.centerY
        }

        self.view.frame = CGRect(x: 0, y: 0, width: 400, height: 250)
    }

    @objc func dismiss(button: NSButton) {
        if let presentedVC = self.presentingViewController {
            presentedVC.dismiss(self)
        } else if let window = self.view.window {
            window.close()
        } else {
            self.view.removeFromSuperview()
        }
    }
    
}

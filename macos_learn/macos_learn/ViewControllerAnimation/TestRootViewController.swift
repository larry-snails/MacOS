//
//  TestRootViewController.swift
//  macos_learn
//
//  Created by 吕志滨 on 2019/8/8.
//  Copyright © 2019 吕志滨. All rights reserved.
//

import Cocoa

class TestRootViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initButtons()
    }

    func initButtons() {
        let arr = ["Modal", "Sheet", "Popover", "Animator", "show"];
        for (index, title) in arr.enumerated() {
            let button = NSButton(title: title, target: self, action: #selector(buttonClick(button:)))
            button.tag = index
            button.frame = NSRect(x: 100, y: 50 + 50*index, width: 100, height: 30)
            button.bezelStyle = .rounded
            self.view.addSubview(button)
        }
    }

    @objc func buttonClick(button: NSButton) {
        let tag = button.tag
        if tag == 0 {
            presentModal()
        } else if tag == 1 {
            presentSheet()
        } else if tag == 2 {
            presentPopover(point: button.frame.origin)
        } else if tag == 3 {
            presentAnimation()
        } else if tag == 4 {
            presentShow()
        }
    }

    func presentModal() {
        let dismissController = TestDismissController()
        self.presentAsModalWindow(dismissController)
    }

    func presentSheet() {
        let dismissController = TestDismissController()
        self.presentAsSheet(dismissController)
    }

    func presentPopover(point: NSPoint) {
        let dismissController = TestDismissController()
        dismissController.view.frame.size = NSSize(width: 100, height: 50)
        self.present(dismissController, asPopoverRelativeTo: NSRect(x: point.x, y: point.y, width: 120, height: 60), of: self.view, preferredEdge: NSRectEdge.maxX, behavior: NSPopover.Behavior.transient)
    }

    func presentAnimation() {
        let dismissController = TestDismissController()
        self.present(dismissController, animator: PresentCustomerAnimation())
    }

    func presentShow() {
        let dismissController = TestDismissController()
        let viewController = NSViewController()
        self.addChild(viewController)
        self.addChild(dismissController)
        self.view.addSubview(dismissController.view)
        self.transition(from: viewController, to: dismissController, options: NSViewController.TransitionOptions.crossfade, completionHandler: nil)
    }

}

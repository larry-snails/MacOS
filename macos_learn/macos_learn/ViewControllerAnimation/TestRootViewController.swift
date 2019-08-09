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
        addGestureRecognizer()
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

    func addGestureRecognizer() {

        let gestureView = BaseView(frame: NSRect(x: 200, y: 50, width: 300, height: 300))
        gestureView.layer?.backgroundColor = NSColor.yellow.cgColor
        self.view.addSubview(gestureView)

        // 点击手势
        let gesture = NSClickGestureRecognizer(target: self, action: #selector(clickGesture(_:)))
        gesture.numberOfClicksRequired = 1
        gestureView.addGestureRecognizer(gesture)

        //滑动手势
        let pan = NSPanGestureRecognizer(target: self, action: #selector(panGesture(_:)))
        gestureView.addGestureRecognizer(pan)

        //滑动手势
        let press = NSPressGestureRecognizer(target: self, action: #selector(pressGesture(_:)))
        press.minimumPressDuration = 1
        gestureView.addGestureRecognizer(press)

        //滑动手势
        let manification = NSMagnificationGestureRecognizer(target: self, action: #selector(manificationGesture(_:)))
        gestureView.addGestureRecognizer(manification)

        //滑动手势
        let rotation = NSRotationGestureRecognizer(target: self, action: #selector(rotationGesture(_:)))
        gestureView.addGestureRecognizer(rotation)
    }

    @objc func clickGesture(_ gesture: NSClickGestureRecognizer) {
        let point = gesture.location(in: gesture.view)
        print("clickGesture  at  point: (x: \(point.x), y: \(point.y)")
    }

    @objc func panGesture(_ gesture: NSPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            let point = gesture.location(in: gesture.view)
            print("panGesture begin at point: (x: \(point.x), y: \(point.y)")
        case .ended:
            let point = gesture.location(in: gesture.view)
            print("panGesture end at point: (x: \(point.x), y: \(point.y)")
        case .changed:
            let point = gesture.location(in: gesture.view)
            print("panGesture change at point: (x: \(point.x), y: \(point.y)")
        case .cancelled:
            let point = gesture.location(in: gesture.view)
            print("panGesture cancel at point: (x: \(point.x), y: \(point.y)")
        case .failed:
            let point = gesture.location(in: gesture.view)
            print("panGesture faild at point: (x: \(point.x), y: \(point.y)")
        default:
            break;

        }
    }

    @objc func pressGesture(_ gesture: NSPanGestureRecognizer) {
        let point = gesture.location(in: gesture.view)
        print("pressGesture at point: (x: \(point.x), y: \(point.y)")
    }

    @objc func manificationGesture(_ gesture: NSPanGestureRecognizer) {

    }

    @objc func rotationGesture(_ gesture: NSPanGestureRecognizer) {

    }
}

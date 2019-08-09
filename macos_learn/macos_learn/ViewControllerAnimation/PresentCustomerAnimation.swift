//
//  PresentCustomerAnimation.swift
//  macos_learn
//
//  Created by 吕志滨 on 2019/8/8.
//  Copyright © 2019 吕志滨. All rights reserved.
//

import Cocoa

class PresentCustomerAnimation: NSObject, NSViewControllerPresentationAnimator {
    func animatePresentation(of viewController: NSViewController, from fromViewController: NSViewController) {
        viewController.view.alphaValue = 0
        fromViewController.view.addSubview(viewController.view)
        fromViewController.view.layer?.backgroundColor = NSColor.lightGray.cgColor
        NSAnimationContext.runAnimationGroup { (context) in
            context.duration = 0.5
            viewController.view.animator().alphaValue = 1;
        }
    }

    func animateDismissal(of viewController: NSViewController, from fromViewController: NSViewController) {
        let topVC = viewController
        NSAnimationContext.runAnimationGroup({ (context) in
            context.duration = 0.5
            topVC.view.animator().alphaValue = 0;
        }) {
            topVC.view.removeFromSuperview()
            fromViewController.view.layer?.backgroundColor = NSColor.white.cgColor
        }
    }


}

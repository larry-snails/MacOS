//
//  TextViewController.swift
//  macos_learn
//
//  Created by 吕志滨 on 2019/7/31.
//  Copyright © 2019 吕志滨. All rights reserved.
//

import Cocoa

class TextViewController: NSViewController {

    override func loadView() {
        view = NSView(frame: NSRect(x: 0, y: 0, width: 600, height: 400))
        view.wantsLayer = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTextFields()
        initTextView()
        // Do view setup here.
    }

    func initTextFields() {
        let label = NSTextField(frame: NSRect(x: 50, y: 50, width: 100, height: 50))
        label.cell = VerticalCenteredTextFieldCell(textCell: "")
        label.wantsLayer = true
        label.stringValue = "居中label"
        label.alignment = .center
        label.layer?.backgroundColor = NSColor.yellow.cgColor
        label.isEnabled = false
        self.view.addSubview(label)

        let attrLabel = NSTextField(frame: NSRect(x: 50, y: 120, width: 100, height: 50))
        attrLabel.cell = VerticalCenteredTextFieldCell(textCell: "")
        attrLabel.wantsLayer = true
        attrLabel.alignment = .center
        attrLabel.isEnabled = false
        attrLabel.layer?.backgroundColor = NSColor.yellow.cgColor
        let text = NSMutableAttributedString(string: "富文本label")
        text.addAttributes([NSAttributedString.Key.foregroundColor: NSColor.red, NSAttributedString.Key.font: NSFont.systemFont(ofSize: 10)], range: NSRange(location: 0, length: 3))
        text.addAttributes([NSAttributedString.Key.foregroundColor: NSColor.blue, NSAttributedString.Key.font: NSFont.systemFont(ofSize: 15)], range: NSRange(location: 3, length: 2))
        text.addAttributes([NSAttributedString.Key.foregroundColor: NSColor.green, NSAttributedString.Key.font: NSFont.systemFont(ofSize: 20)], range: NSRange(location: 5, length: 3))
        attrLabel.attributedStringValue = text
        self.view.addSubview(attrLabel)
    }

    func initTextView() {
        let textView = NSTextView(frame: NSRect(x: 50, y: 200, width: 200, height: 100))
        textView.wantsLayer = true
        let rawValue = NSScrollView.AutoresizingMask.width.rawValue | NSScrollView.AutoresizingMask.height.rawValue
        //自动调节高度
        textView.autoresizingMask = NSScrollView.AutoresizingMask(rawValue: rawValue)
        textView.textColor = NSColor.black
        textView.font = NSFont.systemFont(ofSize: 15)
        textView.string = "TextView"
        textView.delegate = self
        textView.minSize = CGSize(width: 100, height: 100)
        textView.maxSize = CGSize(width: 200, height: 200)

        let scrollView = NSScrollView(frame: NSRect(x: 50, y: 200, width: 200, height: 100))
        scrollView.documentView = textView
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = true


        scrollView.autoresizingMask = NSScrollView.AutoresizingMask(rawValue: rawValue)
        self.view.addSubview(scrollView)
    }
    
}


extension TextViewController: NSTextViewDelegate {
    func textDidBeginEditing(_ notification: Notification) {
        if let textView = notification.object as? NSTextView {
            let text = textView.string
            print("textDidBeginEditing text \(text)")

        }
    }

    func textDidEndEditing(_ notification: Notification) {
        if let textView = notification.object as? NSTextView {
            let text = textView.string
            print("textDidEndEditing text \(text)")
        }
    }

    func textDidChange(_ notification: Notification) {
        if let textView = notification.object as? NSTextView {
            let text = textView.string
            print("textDidChange text \(text)")
        }
    }
}

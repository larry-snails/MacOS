//
//  ButtonViewController.swift
//  macos_learn
//
//  Created by 吕志滨 on 2019/7/30.
//  Copyright © 2019 吕志滨. All rights reserved.
//

import Cocoa

class ButtonViewController: NSViewController {

    var box = NSComboBox(frame: NSRect(origin: CGPoint(x: 100, y: 150), size: CGSize(width: 50, height: 25)))

    var stepLabel = NSTextField(frame: NSRect(x: 100, y: 250, width: 80, height: 30))

    var segmentLabel = NSTextField()

    let progress = NSProgressIndicator(frame: NSRect(x: 300, y: 320, width: 100, height: 30))

    override func loadView() {
        view = NSView(frame: NSRect(x: 0, y: 0, width: 600, height: 400))
        view.wantsLayer = true
    }

    var boxDatas = ["1", "2", "3", "4", "5", "6", "7", "8"]

    override func viewDidLoad() {
        super.viewDidLoad()
        initNormalButton()
        initComboBox()
        initPopUpButton()
        addStepper()
        addSwitchButton()
        addCheckButton()
        initSegment()
        addSlicer()
    }

    func initNormalButton() {
        let normalButton = MyButton(frame: CGRect(x: 100, y: 50, width: 100, height: 50))
        normalButton.target = self
        normalButton.action = #selector(normalButtonClick)
        normalButton.title = "normal button"
        normalButton.toolTip = "悬浮标题"
        normalButton.wantsLayer = true
        normalButton.layer?.backgroundColor = NSColor.yellow.cgColor
        normalButton.setButtonType(NSButton.ButtonType.pushOnPushOff)
        // rounded
        // regularSquare
        // disclosure
        // shadowlessSquare
        // circular
        // texturedSquare
        // helpButton
        // smallSquare
        // texturedRounded
        // roundRect
        // recessed
        // roundedDisclosure
        //@available(OSX 10.7, *)
        // inline

        //边框样式
        normalButton.bezelStyle = .regularSquare

        self.view.addSubview(normalButton)
    }

    @objc func normalButtonClick() {
        print("normalButtonClick")
    }

    func initComboBox() {
        box.itemHeight = 25
        box.addItems(withObjectValues: boxDatas)
        box.selectItem(at: 1)
        box.numberOfVisibleItems = 3
        box.usesDataSource = true
        box.delegate = self
        box.dataSource = self
        self.view.addSubview(box)
    }

    func initPopUpButton() {
        let popUpButton = NSPopUpButton(frame: NSRect(origin: CGPoint(x: 100, y: 200), size: CGSize(width: 100, height: 25)), pullsDown: false)
        popUpButton.target = self
        popUpButton.action = #selector(popUpButtonHandel(sender:))
        popUpButton.wantsLayer = true
        popUpButton.isEnabled = true
        popUpButton.addItems(withTitles: boxDatas)
        self.view.addSubview(popUpButton)
    }

    @objc func popUpButtonHandel(sender: NSPopUpButton) {
        print(sender.indexOfSelectedItem)
    }

    func addStepper() {

        stepLabel.isEditable = false
        stepLabel.stringValue = "1.0"
        self.view.addSubview(stepLabel)

        let stepper = NSStepper(frame: NSRect(x: 180, y: 250, width: 20, height: 30))
        stepper.target = self
        stepper.valueWraps = true
        stepper.wantsLayer = true
        stepper.doubleValue = 1
        stepper.maxValue = 10
        stepper.minValue = 0
        stepper.increment = 0.3
        stepper.valueWraps = false
        stepper.autorepeat = false
        stepper.action = #selector(stepperAction(sender:))
        self.view.addSubview(stepper)
    }

    @objc func stepperAction(sender: NSStepper) {
        let str = sender.stringValue
        stepLabel.stringValue = str
    }

    func addSwitchButton() {
        let button = NSButton(frame: NSRect(x: 250, y: 50, width: 100, height: 50))
        button.setButtonType(NSButton.ButtonType.switch)
        // allowsMixedState 设置为true，有3中状态，设置为false 有两种状态
        button.allowsMixedState = true
        button.title = "switch button"
        self.view.addSubview(button)
    }

    func addCheckButton() {
        let boxView = NSBox(frame: NSRect(x: 250, y: 150, width: 100, height: 150))
        boxView.wantsLayer = true
        boxView.title = "性别"

        //单选框需要在相同的父试图上，并且有相同的x点击事件响应方法
        let radioButtonOne = NSButton(frame: NSRect(x: 0, y: 0, width: 100, height: 30))
        radioButtonOne.setButtonType(NSButton.ButtonType.radio)
        radioButtonOne.title = "男"
        radioButtonOne.tag = 0
        radioButtonOne.target = self
        radioButtonOne.action = #selector(radioButtonClick(_:))
        boxView.addSubview(radioButtonOne)

        let radioButtonTwo = NSButton(frame: NSRect(x: 0, y: 50, width: 100, height: 30))
        radioButtonTwo.setButtonType(NSButton.ButtonType.radio)
        radioButtonTwo.title = "女"
        radioButtonTwo.tag = 2
        radioButtonTwo.target = self
        radioButtonTwo.action = #selector(radioButtonClick(_:))
        boxView.addSubview(radioButtonTwo)

        let radioButtonThree = NSButton(frame: NSRect(x: 0, y: 100, width: 100, height: 30))
        radioButtonThree.setButtonType(NSButton.ButtonType.radio)
        radioButtonThree.title = "人妖"
        radioButtonThree.tag = 3
        radioButtonThree.target = self
        radioButtonThree.action = #selector(radioButtonClick(_:))
        boxView.addSubview(radioButtonThree)

        self.view.addSubview(boxView)
    }

    @objc func radioButtonClick(_ sender: NSButton) {
        print(sender.tag)
    }

    func initSegment() {
        let segement = NSSegmentedControl(frame: NSRect(x: 100, y: 300, width: 160, height: 30))
        segement.selectedSegmentBezelColor = NSColor.green
        segement.target = self
        segement.layer?.backgroundColor = NSColor.red.cgColor
        segement.wantsLayer = true
        segement.action = #selector(segmentClick(_:))
        segement.segmentStyle = NSSegmentedControl.Style.rounded
        segement.segmentCount = 3
        segement.setLabel("left", forSegment: 0)
        segement.setWidth(50, forSegment: 0)
        segement.setLabel("center", forSegment: 1)
        segement.setWidth(50, forSegment: 1)
        segement.setLabel("right", forSegment: 2)
        segement.setWidth(50, forSegment: 2)
        segement.selectedSegment = 0
        self.view.addSubview(segement)

        segmentLabel.isEditable = false
        segmentLabel.stringValue = "Alignment Left"
        segmentLabel.isBordered = false
        segmentLabel.font = NSFont.systemFont(ofSize: 15)
        segmentLabel.frame = NSRect(x: 100, y: 330, width: 160, height: 20)
        self.view.addSubview(segmentLabel)
    }

    @objc func segmentClick(_ sender: NSSegmentedControl) {
        let index = sender.indexOfSelectedItem
        if index == 0 {
            segmentLabel.alignment = .left
            segmentLabel.stringValue = "Alignment Left"
        } else if index == 1 {
            segmentLabel.alignment = .center
            segmentLabel.stringValue = "Alignment Center"
        } else if index == 2 {
            segmentLabel.alignment = .right
            segmentLabel.stringValue = "Alignment Right"
        }
    }

    func addSlicer() {
        let slider = NSSlider(value: 0.3, minValue: 0.0, maxValue: 1.0, target: self, action: #selector(sliderChange(_:)))
        slider.trackFillColor = NSColor.red
        
        slider.frame = NSRect(x: 300, y: 300, width: 100, height: 10)
        self.view.addSubview(slider)

        progress.maxValue = 1.0
        progress.minValue = 0.0
        progress.doubleValue = 0.3
        progress.wantsLayer = true
        progress.style = .bar
        progress.controlSize = .regular
        progress.isIndeterminate = false ////设置是精准的进度条还是模糊的指示器,false-精度
        self.view.addSubview(progress)
    }

    @objc func sliderChange(_ sender: NSSlider) {
        progress.doubleValue = sender.doubleValue
    }
}

extension ButtonViewController: NSComboBoxDelegate, NSComboBoxDataSource, NSTextFieldDelegate {

    func controlTextDidChange(_ obj: Notification) {
        print(box.stringValue)
    }

    func numberOfItems(in comboBox: NSComboBox) -> Int {
        return self.boxDatas.count
    }

    func comboBox(_ comboBox: NSComboBox, objectValueForItemAt index: Int) -> Any? {
        return boxDatas[index]
    }


    func comboBox(_ comboBox: NSComboBox, indexOfItemWithStringValue string: String) -> Int {
        return boxDatas.firstIndex(of: string) ?? 0
    }

    func comboBox(_ comboBox: NSComboBox, completedString string: String) -> String? {
        return string
    }

    func comboBoxWillPopUp(_ notification: Notification) {
        print(comboBoxWillPopUp)
    }

    func comboBoxWillDismiss(_ notification: Notification) {
        print(comboBoxWillDismiss)
    }

    func comboBoxSelectionDidChange(_ notification: Notification) {
        let selectIndex = box.indexOfSelectedItem
        print(boxDatas[selectIndex])
    }

    func comboBoxSelectionIsChanging(_ notification: Notification) {
        print(comboBoxSelectionIsChanging)
    }
}

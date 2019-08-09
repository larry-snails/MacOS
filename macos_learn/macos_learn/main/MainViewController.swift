//
//  MainViewController.swift
//  macos_learn
//
//  Created by 吕志滨 on 2019/7/29.
//  Copyright © 2019 吕志滨. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {

    lazy var tableView: NSTableView = { [unowned self] in
        let table = NSTableView(frame: NSRect(x: 0, y: 0, width: 600, height: 400))
        table.wantsLayer = true
        table.delegate = self
        table.dataSource = self
        table.usesAlternatingRowBackgroundColors = true
        table.headerView = nil
        table.selectionHighlightStyle = .none
        let scrollView = NSScrollView(frame: NSRect(x: 0, y: 0, width: 600, height: 400))
        scrollView.backgroundColor = .red
        scrollView.documentView = table
        scrollView.hasHorizontalScroller = true
        scrollView.hasVerticalRuler = true
        scrollView.autohidesScrollers = true
        scrollView.drawsBackground = true
        return table
    }()

    lazy var scrollView: NSScrollView = { [unowned self] in
        let scrollView = NSScrollView(frame: NSRect(x: 0, y: 0, width: 600, height: 400))
        scrollView.backgroundColor = .red
        scrollView.documentView = self.tableView
        scrollView.hasHorizontalScroller = true
        scrollView.hasVerticalRuler = true
        scrollView.autohidesScrollers = true
        scrollView.drawsBackground = true
        return scrollView
        }()

    let buttonVC = ButtonViewController()

    let textVC = TextViewController()

    var datas = ["Button", "输入框", "串口", "视图控制器"]

    let identify = NSUserInterfaceItemIdentifier(rawValue: "MainTableCellView")

    override func loadView() {
        view = NSView(frame: NSRect(x: 0, y: 0, width: 600, height: 400))
        view.wantsLayer = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Main"
        initUI()
    }

    func initUI() {
        self.view.addSubview(self.scrollView)
        let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "MainTableCellView"))
        column.title = ""
        column.width = 500
        column.resizingMask = NSTableColumn.ResizingOptions.autoresizingMask
        tableView.addTableColumn(column)

        let tap = NSClickGestureRecognizer(target: self, action: #selector(tapClick(_:)))
        tableView.addGestureRecognizer(tap)
    }

    @objc func tapClick(_ event: NSClickGestureRecognizer) {
       let point = event.location(in: tableView)
        let rowIndex = tableView.row(at: point)
        let columnIndex = tableView.column(at: point)
        guard rowIndex >= 0, columnIndex >= 0 else {
            return
        }
        if rowIndex == 0 {
            buttonVC.title = "按钮"
            self.presentAsModalWindow(buttonVC)
        } else if rowIndex == 1 {
            textVC.title = "输入框"
            self.presentAsModalWindow(textVC)
        } else if rowIndex == 2 {
            let ioViewController = IOTestViewController()
            self.present(ioViewController, animator: Animation())
        } else if rowIndex == 3 {
            let testVC = TestRootViewController(nibName: nil, bundle: nil)
            self.presentAsModalWindow(testVC)
        }
    }
    
}

extension MainViewController: NSTableViewDelegate, NSTableViewDataSource {

    func numberOfRows(in tableView: NSTableView) -> Int {
        return datas.count
    }

    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: identify, owner: self)
        guard let rowView = cell as? MainTableCellView else {
            let cellView = MainTableCellView()
            cellView.showData(str: datas[row])
            cellView.identifier = identify
            return cellView
        }
        rowView.showData(str: datas[row])
        return rowView
    }

}

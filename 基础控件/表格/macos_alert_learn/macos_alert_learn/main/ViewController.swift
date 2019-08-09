//
//  ViewController.swift
//  macos_alert_learn
//
//  Created by 吕志滨 on 2019/7/29.
//  Copyright © 2019 吕志滨. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var tableView: NSTableView!

    var datas = ["输入框",
                "按钮",
                "Alert",
                "Panel",
                "NSOutlineView"]

    var identify = NSUserInterfaceItemIdentifier(rawValue: "type")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }

    func initUI() {
        let column = NSTableColumn(identifier: identify)
        self.tableView.addTableColumn(column)

    }

    override var representedObject: Any? {
        didSet {

        }
    }


}

extension ViewController: NSTableViewDelegate, NSTableViewDataSource {

    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.datas.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let view = tableView.makeView(withIdentifier: identify, owner: self) as? NSTableCellView else {
            return nil
        }
        view.textField?.stringValue = datas[row]
        return view
    }
}

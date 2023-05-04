//
//  DigitsPickerScreen01ViewController.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2023/05/03.
//  Copyright © 2023 里 佳史. All rights reserved.
//

import UIKit

final class DigitsPickerScreen01: SettingsAttachedScreen {
    
    let cellReuseId = "digits01"
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetUp()
        navigationBarSetUp()
    }
    
    private func navigationBarSetUp() {
        self.title = "1の位の数で選ぶ"
//        navigationItem.rightBarButtonItems = [
//            selectedNumBadgeItem
//        ]
    }

    private func tableViewSetUp() {
        self.tableView = createTableViewForScreen()
        tableView.register(NgramPickerTableCell.self, forCellReuseIdentifier: cellReuseId);        view.addSubview(tableView)
    }
    
    private func createTableViewForScreen() -> UITableView {
        let tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.dataSource = self
//        tableView.delegate = self
        return tableView
    }
}
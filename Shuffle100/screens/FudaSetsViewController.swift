//
//  FudaSetsViewController.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/05/25.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit


class FudaSetsViewController: SettingsAttachedViewController {
    internal let cellReuseId = "fudaSets"
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.prompt = "百首読み上げ"
        self.title = "作った札セットから選ぶ"
        self.tableView = createTableViewForScreen()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseId)
        view.addSubview(tableView)
    }
    

    private func createTableViewForScreen() -> UITableView {
        let tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }

}

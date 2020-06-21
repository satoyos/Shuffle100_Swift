//
//  HelpListViewController.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/06/20.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

class HelpListViewController: UIViewController {
    var tableView: UITableView!
    let cellReuseId = "HelpList"

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "ヘルプ"
        self.tableView = createTableViewForScreen()
        tableView.register(HelpListTableViewCell.self, forCellReuseIdentifier: cellReuseId)
        view.addSubview(tableView)
    }
    
    private func createTableViewForScreen() -> UITableView {
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }
}

//
//  FudaSetsScreen.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/05/25.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit


final class FudaSetsScreen: SettingsAttachedScreen {
    internal let cellReuseId = "fudaSets"
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "作った札セットから選ぶ"
        self.tableView = createTableViewForScreen()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseId)
        view.addSubview(tableView)
    }

    override func viewWillDisappear(_ animated: Bool) {
        saveSettingsAction?()
        super.viewWillDisappear(animated)
    }

    private func createTableViewForScreen() -> UITableView {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }

}

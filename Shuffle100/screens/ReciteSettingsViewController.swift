//
//  ReciteSettingsViewController.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/03/01.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
//import Then

class ReciteSettingsViewController: SettingsAttachedViewController {
    let reuseID = ReciteSettingsTableCell.identifier
    var tableView: UITableView!
    let settingNames = ["歌と歌の間隔", "上の句と下の句の間隔", "音量調整"]
    var intervalSettingAction: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "いろいろな設定"
        view.backgroundColor = StandardColor.backgroundColor
        self.tableView = createTableViewForReciteSettingsScreen()
        view.addSubview(tableView)        
    }

    private func createTableViewForReciteSettingsScreen() -> UITableView {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ReciteSettingsTableCell.self, forCellReuseIdentifier: reuseID)
        return tableView
    }
}

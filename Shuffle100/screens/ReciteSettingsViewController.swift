//
//  ReciteSettingsViewController.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/03/01.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

class ReciteSettingsViewController: SettingsAttachedViewController {
    let reuseID = ReciteSettingsTableCell.identifier
    var tableView: UITableView!
    var tableSources: [TableDataSource]!
    var intervalSettingAction: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "いろいろな設定"
        view.backgroundColor = StandardColor.backgroundColor
        self.tableView = createTableViewForReciteSettingsScreen()
        setUpTableSources()
        view.addSubview(tableView)        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpTableSources()
        tableView.reloadData()
        super.viewWillAppear(animated)
    }

    private func createTableViewForReciteSettingsScreen() -> UITableView {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ReciteSettingsTableCell.self, forCellReuseIdentifier: reuseID)
        return tableView
    }
    
    private func setUpTableSources() {
        self.tableSources = [
            TableDataSource(title: "歌と歌の間隔", accessoryType: .disclosureIndicator, detailLabelText: String(format: "%.2F", settings.interval)),
            TableDataSource(title: "上の句と下の句の間隔", accessoryType: .disclosureIndicator, detailLabelText: String(format: "%.2F", settings.kamiShimoInterval)),
            TableDataSource(title: "音量調整", accessoryType: .disclosureIndicator, detailLabelText: "")
        ]
    }
}

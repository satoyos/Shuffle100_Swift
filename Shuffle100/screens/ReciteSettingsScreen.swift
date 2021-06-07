//
//  ReciteSettingsScreen.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/03/01.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

final class ReciteSettingsScreen: SettingsAttachedScreen {
    internal let reuseID = "ReciteSettingsTableCell"
    var tableView: UITableView!
    var tableSources: [SettingsCellDataSource]!
    var intervalSettingAction: (() -> Void)?
    var kamiShimoIntervalSettingAction: (() -> Void)?
    var volumeSettingAction: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "いろいろな設定"
        configureDismissButton()
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
        tableView.register(SettingTableCell.self, forCellReuseIdentifier: reuseID)
        return tableView
    }
    
    private func setUpTableSources() {
        self.tableSources = [
            SettingsCellDataSource(title: "歌と歌の間隔", accessoryType: .disclosureIndicator, secondaryText: String(format: "%.2F", settings.interval)),
            SettingsCellDataSource(title: "上の句と下の句の間隔", accessoryType: .disclosureIndicator, secondaryText: String(format: "%.2F", settings.kamiShimoInterval)),
            SettingsCellDataSource(title: "音量調整", accessoryType: .disclosureIndicator, secondaryText: "\(Int(settings.volume * 100))" + "%"),
            postMotermTableDataSource(),
            shortenJokaTableDataSource()
        ]
    }
    
    private func configureDismissButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "設定終了", style: .plain, target: self, action: #selector(dismissButtonTapped))
    }

    private func postMotermTableDataSource() -> SettingsCellDataSource {
        var dataSource =             SettingsCellDataSource(title: "試合後に感想戦を選択できる", accessoryType: .none, secondaryText: "感想戦では、同じ歌を同じ順序で読み上げます。", configType: .subtitleCell())
        dataSource.withSwitchOf = settings.postMortemEnabled
        return dataSource
    }
    
    private func shortenJokaTableDataSource() -> SettingsCellDataSource {
        var dataSource = SettingsCellDataSource(title: "序歌の読み上げ時間を短縮", accessoryType: .none, secondaryText: "序歌は、下の句を1回だけ読み上げます。", configType: .subtitleCell())
        dataSource.withSwitchOf = settings.shortenJoka
        return dataSource
    }

}

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
//    var tableSources: [SettingsCellDataSource]!
    var sections: [TableSection]!
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
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SettingTableCell.self, forCellReuseIdentifier: reuseID)
        return tableView
    }
    
    private func setUpTableSources() {
        self.sections = [
            createInervalSection(),
            createVolumeSection(),
            createModeSection()
        ]
    }
    
    private func createInervalSection() -> TableSection {
        var intervalSection = TableSection(title: "読み上げの間隔(秒)")
        intervalSection.dataSources = [
            SettingsCellDataSource(title: "歌と歌の間隔", accessoryType: .disclosureIndicator, secondaryText: String(format: "%.2F", settings.interval)),
            SettingsCellDataSource(title: "上の句と下の句の間隔", accessoryType: .disclosureIndicator, secondaryText: String(format: "%.2F", settings.kamiShimoInterval))
        ]
        return intervalSection
    }
    
    private func createVolumeSection() -> TableSection {
        var volumeSection = TableSection(title: "音量")
        volumeSection.dataSources = [
            SettingsCellDataSource(title: "音量調整", accessoryType: .disclosureIndicator, secondaryText: "\(Int(settings.volume * 100))" + "%"),
        ]
        return volumeSection
    }
    
    private func createModeSection() -> TableSection {
        var modeSection = TableSection(title: "試合の詳細なモード")
        modeSection.dataSources = [
            shortenJokaTableDataSource(),
            postMotermTableDataSource()
        ]
        return modeSection
    }
    
    private func configureDismissButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "設定終了", style: .plain, target: self, action: #selector(dismissButtonTapped))
    }

    private func postMotermTableDataSource() -> SettingsCellDataSource {
        var dataSource =             SettingsCellDataSource(title: "試合後に感想戦を選択できる", accessoryType: .none, secondaryText: "感想戦では、同じ歌を同じ順序で読み上げます。", configType: .subtitleCell())
        dataSource.withSwitchOf = settings.postMortemEnabled
        dataSource.accessibilityLabel = "postMortemMode"
        return dataSource
    }
    
    private func shortenJokaTableDataSource() -> SettingsCellDataSource {
        var dataSource = SettingsCellDataSource(title: "序歌の読み上げ時間を短縮", accessoryType: .none, secondaryText: "序歌は、下の句を1回だけ読み上げます。", configType: .subtitleCell())
        dataSource.withSwitchOf = settings.shortenJoka
        dataSource.accessibilityLabel = "shortenJokaMode"
        return dataSource
    }

}

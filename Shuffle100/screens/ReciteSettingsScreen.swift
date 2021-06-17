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
    var sections: [TableSection]!
    var intervalSettingAction: (() -> Void)?
    var kamiShimoIntervalSettingAction: (() -> Void)?
    var volumeSettingAction: (() -> Void)?

    enum A11y {
        static let screenTitle = "いろいろな設定"
        static let intervalSectionTitle = "読み上げの間隔(秒)"
        static let volumeSectionTitle = "音量"
        static let detailGameModeScttionTitle = "試合のモードあれこれ"
        static let intervalCellTitle = "歌と歌の間隔"
        static let kamiShimoIntervalCellTitle = "上の句と下の句の間隔"
        static let volumeCellTitle = "音量調整"
        static let shortenJokaCellTitle = "序歌の読み上げ時間を短縮"
        static let shortenJokaA11yLabel = "shortenJokaMode"
        static let postMortemCellTitle = "試合後に感想戦を選択できる"
        static let postMortemA11yLabel = "postMortemMode"
        static let exitSetting = "設定終了"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = A11y.screenTitle
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
        var intervalSection = TableSection(title: A11y.intervalSectionTitle)
        intervalSection.dataSources = [
            SettingsCellDataSource(title: A11y.intervalCellTitle, accessoryType: .disclosureIndicator, secondaryText: String(format: "%.2F", settings.interval)),
            SettingsCellDataSource(title: A11y.kamiShimoIntervalCellTitle, accessoryType: .disclosureIndicator, secondaryText: String(format: "%.2F", settings.kamiShimoInterval))
        ]
        return intervalSection
    }
    
    private func createVolumeSection() -> TableSection {
        var volumeSection = TableSection(title: A11y.volumeSectionTitle)
        volumeSection.dataSources = [
            SettingsCellDataSource(title: A11y.volumeCellTitle, accessoryType: .disclosureIndicator, secondaryText: "\(Int(settings.volume * 100))" + "%"),
        ]
        return volumeSection
    }
    
    private func createModeSection() -> TableSection {
        var modeSection = TableSection(title: A11y.detailGameModeScttionTitle)
        modeSection.dataSources = [
            shortenJokaTableDataSource(),
            postMotermTableDataSource()
        ]
        return modeSection
    }
    
    private func configureDismissButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: A11y.exitSetting, style: .plain, target: self, action: #selector(dismissButtonTapped))
    }

    private func postMotermTableDataSource() -> SettingsCellDataSource {
        var dataSource =             SettingsCellDataSource(title: A11y.postMortemCellTitle, accessoryType: .none, secondaryText: "感想戦では、同じ歌を同じ順序で読み上げます。", configType: .subtitleCell())
        dataSource.withSwitchOf = settings.postMortemEnabled
        dataSource.accessibilityLabel = A11y.postMortemA11yLabel
        return dataSource
    }
    
    private func shortenJokaTableDataSource() -> SettingsCellDataSource {
        var dataSource = SettingsCellDataSource(title: A11y.shortenJokaCellTitle, accessoryType: .none, secondaryText: "序歌は、下の句を1回だけ読み上げます。", configType: .subtitleCell())
        dataSource.withSwitchOf = settings.shortenJoka
        dataSource.accessibilityLabel = A11y.shortenJokaA11yLabel
        return dataSource
    }

}

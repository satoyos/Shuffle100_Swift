//
//  HomeViewControllerDataSource.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2018/10/06.
//  Copyright © 2018 里 佳史. All rights reserved.
//

import UIKit

struct TableSection {
    var title: String
    var dataSources: [DataSource]
    
    init(title: String) {
        self.title = title
        self.dataSources = [DataSource]()
    }
}

struct DataSource {
    var title: String
    var accessoryType: UITableViewCell.AccessoryType
    var accessibilityLabel: String!
    var withSwitch: Bool
    var detailLabelText: String
    var gameSettings: GameSettings
    
    init(title: String, accessoryType type: UITableViewCell.AccessoryType, detailLabelText: String = "", withSwitch: Bool = false, gameSettings settings: GameSettings = GameSettings()) {
        self.title = title
        self.accessoryType = type
        self.withSwitch = withSwitch
        self.detailLabelText = detailLabelText
        self.gameSettings = settings
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func setupDataSources(withTypes types: [HomeCellType]) {
        sections = [TableSection]()
        sections.append(settingSection(withTypes: types))
        sections.append(gameStartSection())
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].dataSources.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeScreenTableCell.identifier, for: indexPath) as! HomeScreenTableCell
            
            cell.configure(dataSource: sections[indexPath.section].dataSources[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: GameStartCell.identifier, for: indexPath) as! GameStartCell
            
            cell.configure(dataSource: sections[indexPath.section].dataSources[indexPath.row])
            return cell
        }
    }
    
    private func settingSection(withTypes types: [HomeCellType]) -> TableSection {
        var section = TableSection(title: "設定")
        section.dataSources = types.map{
            HomeScreenDataSourceFactory.settingsDataSource(for: $0, settings: gameSettings)}
        return section
    }
    
    private func gameStartSection() -> TableSection {
        var section = TableSection(title: "試合開始")
        var dataSource = HomeScreenDataSourceFactory.startGameDataSource()
        dataSource.accessibilityLabel = GameStartCell.identifier
        section.dataSources = [dataSource]
        return section
    }
}

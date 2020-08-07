//
//  HomeScreenDataSource.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/03/22.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func setupDataSources(withTypes types: [HomeCellType]) {
        self.sections = [TableSection]()
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
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeScreenTableCell.identifier) as! HomeScreenTableCell
            
            cell.configure(dataSource: sections[indexPath.section].dataSources[indexPath.row])
            if let switchView = cell.accessoryView as? UISwitch {
                switchView.addTarget(self, action: #selector(switchValueChanged) , for: .valueChanged)
            }
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
            HomeScreenDataSourceFactory.settingsDataSource(for: $0, settings: settings)}
        return section
    }
    
    private func gameStartSection() -> TableSection {
        var section = TableSection(title: "試合開始")
        var dataSource = HomeScreenDataSourceFactory.startGameDataSource()
        dataSource.accessibilityLabel = GameStartCell.identifier
        section.dataSources = [dataSource]
        if settings.reciteMode == .normal {
            let timerCell = HomeScreenDataSourceFactory.memorizeTimerDataSource()
            section.dataSources.insert(timerCell, at: 0)
        }
        return section
    }
}


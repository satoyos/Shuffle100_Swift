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
    var cellLabel: String!
    
    init(title: String, cellType type: UITableViewCell.AccessoryType) {
        self.title = title
        self.accessoryType = type
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func setupDataSources(withTypes types: [HomeCellType]) {
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
    
    fileprivate func settingSection(withTypes types: [HomeCellType]) -> TableSection {
        var section = TableSection(title: "設定")
        for type in types {
            var dataSource: DataSource!
            
            switch type {
            case .poems:
                dataSource = poemsDataSource()
            case .reciteMode:
                dataSource = reciteModeDataSource()
            case .beginnerMode:
                dataSource = beginnerModeDataSource()
            case .singers:
                dataSource = singerDataSource()
            case .startGame:
                dataSource = startGameDataSource()
            }
            dataSource.cellLabel = type.rawValue
            section.dataSources.append(dataSource)
        }
        return section
    }
    
    fileprivate func gameStartSection() -> TableSection {
        var section = TableSection(title: "試合開始")
        var dataSource = startGameDataSource()
        dataSource.cellLabel = HomeCellType.startGame.rawValue
        section.dataSources.append(dataSource)
        return section
    }
    
    fileprivate func poemsDataSource() -> DataSource {
        return DataSource(title: "取り札を用意する歌", cellType: .disclosureIndicator)
    }
    
    fileprivate func reciteModeDataSource() -> DataSource {
        return DataSource(title: "読み上げモード", cellType: .disclosureIndicator)
    }
    
    fileprivate func beginnerModeDataSource() -> DataSource {
        return DataSource(title: "初心者モード", cellType: .none)
    }
    
    fileprivate func singerDataSource() -> DataSource {
        return DataSource(title: "読手", cellType: .disclosureIndicator)
    }
    
    fileprivate func startGameDataSource() -> DataSource {
        return DataSource(title: "試合開始", cellType: .none)
    }
}

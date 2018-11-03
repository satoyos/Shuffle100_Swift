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
    
    init(title: String, cellType type: UITableViewCell.AccessoryType) {
        self.title = title
        self.accessoryType = type
    }
}

class HomeScreenTableCell: UITableViewCell {
    static let identifier = "HomeScreenTableCell"
    
    func configure(dataSource: DataSource) {
        textLabel?.text = dataSource.title
        accessoryType = dataSource.accessoryType
    }
}

class HomeViewControllerDataSource: NSObject, UITableViewDataSource {
    fileprivate var sections = [TableSection]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    //    ToDo: このDataSourceプロトコルをsetup()メソッドで DataSourceを使って実装していく

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
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeScreenTableCell.identifier, for: indexPath)
        if let cell = cell as? HomeScreenTableCell {
            cell.configure(dataSource: sections[indexPath.section].dataSources[indexPath.row])
        } 
        return cell
    }
    
    fileprivate func settingSection(withTypes types: [HomeCellType]) -> TableSection {
        var section = TableSection(title: "設定")
        for type in types {
            switch type {
            case .poems:
                section.dataSources.append(poemsDataSource())
            case .reciteMode:
                section.dataSources.append(reciteModeDataSource())
            case .beginnerMode:
                section.dataSources.append(beginnerModeDataSource())
            case .singers:
                section.dataSources.append(singerDataSource())
            }
        }
        return section
    }
    
    fileprivate func gameStartSection() -> TableSection {
        var section = TableSection(title: "試合開始")
        section.dataSources.append(DataSource(title: "試合開始", cellType: .none))
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
}

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
    var withSwitch: Bool!
    var detailLabelText: String!
    
    init(title: String, accessoryType type: UITableViewCell.AccessoryType, detailLabelText: String = "", withSwitch: Bool = false) {
        self.title = title
        self.accessoryType = type
        self.withSwitch = withSwitch
        self.detailLabelText = detailLabelText
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
            case .fakeMode:
                dataSource = fakeModeDataSource()
            case .singers:
                dataSource = singerDataSource()
            }
            dataSource.accessibilityLabel = type.rawValue
            section.dataSources.append(dataSource)
        }
        return section
    }
    
    fileprivate func gameStartSection() -> TableSection {
        var section = TableSection(title: "試合開始")
        var dataSource = startGameDataSource()
        dataSource.accessibilityLabel = GameStartCell.identifier
        section.dataSources.append(dataSource)
        return section
    }
    
    fileprivate func poemsDataSource() -> DataSource {
        return DataSource(title: "取り札を用意する歌", accessoryType: .disclosureIndicator)
    }
    
    fileprivate func reciteModeDataSource() -> DataSource {
        return DataSource(title: "読み上げモード", accessoryType: .disclosureIndicator, detailLabelText: textForReciteMode())
    }
    
    fileprivate func fakeModeDataSource() -> DataSource {
        return DataSource(title: "空札を加える", accessoryType: .none, withSwitch: true)
    }
    
    fileprivate func singerDataSource() -> DataSource {
        return DataSource(title: "読手", accessoryType: .disclosureIndicator)
    }
    
    fileprivate func startGameDataSource() -> DataSource {
        return DataSource(title: "試合開始", accessoryType: .none)
    }
    
    fileprivate func textForReciteMode() -> String {
        var detailLabelText: String
        
        switch gameSettings.reciteMode {
        case .normal:
            detailLabelText = "通常"
        case .beginner:
            detailLabelText = "初心者"
        case .nonstop:
            detailLabelText = "ノンストップ"
        }
        return detailLabelText
    }
}

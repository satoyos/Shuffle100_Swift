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
    
    init(title: String) {
        self.title = title
    }
}

class HomeScreenTableCell: UITableViewCell {
    static let identifier = "HomeScreenTableCell"
    
    func configure(dataSource: DataSource) {
        textLabel?.text = dataSource.title
        accessoryType = .disclosureIndicator
    }
}

class HomeViewControllerDataSource: NSObject, UITableViewDataSource {
    fileprivate var sections = [TableSection]()
    
    override init() {
        super.init()
        self.setupDataSources()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    //    ToDo: このDataSourceプロトコルをsetup()メソッドで DataSourceを使って実装していく

    func setupDataSources() {
        sections.append(settingSection())
        sections.append(gameStartSection())
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return [4, 1][section]
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeScreenTableCell.identifier) as! UITableViewCell

        cell.textLabel?.text = sections[indexPath.section].dataSources[indexPath.row].title
        return cell
    }
    
    fileprivate func settingSection() -> TableSection {
        var section = TableSection(title: "設定")
        section.dataSources.append(DataSource(title: "取り札を用意する歌"))
        section.dataSources.append(DataSource(title: "読み上げモード"))
        section.dataSources.append(DataSource(title: "初心者モード"))
        section.dataSources.append(DataSource(title: "読手"))
        
        return section
    }
    
    fileprivate func gameStartSection() -> TableSection {
        var section = TableSection(title: "試合開始")
        section.dataSources.append(DataSource(title: "試合開始"))
        return section
    }
    
}

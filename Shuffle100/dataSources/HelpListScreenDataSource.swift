//
//  HelpListScreenDataSource.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/06/21.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import Then

struct HelpListDataSource {
    enum SourceType {
        case html
        case value1
    }
    let name: String
    let type: SourceType
    let fileName: String?
    var detail: String? = nil
}

struct HelpListSection {
    let name: String
    let dataSources: [HelpListDataSource]
}

private let helpListSections: [HelpListSection] = [
    HelpListSection(name: "使い方", dataSources: [
        HelpListDataSource(name: "設定できること", type: .html, fileName: "aaa"),
        HelpListDataSource(name: "試合の流れ (通常モード)", type: .html, fileName: "bbb"),
        HelpListDataSource(name: "「初心者モード」とは？", type: .html, fileName: "ccc"),
        HelpListDataSource(name: "試合の流れ (初心者モード)", type: .html,  fileName: "ddd"),
        HelpListDataSource(name: "「ノンストップ・モード」とは？", type: .html, fileName: "eee"),
        HelpListDataSource(name: "「札セット」とその使い方", type: .html, fileName: "fff")
    ]),
    HelpListSection(name: "その他", dataSources: [
        HelpListDataSource(name: "「いなばくん」について", type: .html, fileName: "hhh"),
        HelpListDataSource(name: "このアプリを評価する", type: .html, fileName: "iii"),
        HelpListDataSource(name: "バージョン", type: .value1, fileName: nil, detail: "")
    ])
]

extension HelpListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return helpListSections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return helpListSections[section].name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return helpListSections[section].dataSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath).then {
            let section = helpListSections[indexPath.section]
            let dataSource = section.dataSources[indexPath.row]
            $0.textLabel?.text = dataSource.name
        }
        return cell
    }
    
    
}

//
//  HelpListScreenDataSource.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/06/21.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as! HelpListTableViewCell
        let section = helpListSections[indexPath.section]
        let dataSource = section.dataSources[indexPath.row]
        cell.configure(with: dataSource)
        
        return cell
    }
    
    
}

//
//  ReciteSettingsScreenDataSource.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/03/11.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

extension ReciteSettingsScreen: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].dataSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! SettingTableCell        
        guard let source = sections[indexPath.section].dataSources[indexPath.row] as? SettingsCellDataSource else {
            assertionFailure("Couldn't get TableDataSource as SettingsCellDataSource")
            return cell
        }
        cell.configure(dataSource: source)
        if let switchView = cell.accessoryView as? UISwitch {
            switchView.addTarget(self, action: #selector(switchValueChanged) , for: .valueChanged)
        }
        return cell
    }
}

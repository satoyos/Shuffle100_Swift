//
//  ReciteSettingsScreenDataSource.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/03/11.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

extension ReciteSettingsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath).then {
            
            let name = settingNames[indexPath.row]
            $0.accessoryType = .disclosureIndicator

            /////////////////////////////
            //   JUST WRITING AROUND HERE
            /////////////////////////////
            
            $0.textLabel?.text = name
            $0.detailTextLabel?.text = "1.10"
        }
        return cell
    }
}

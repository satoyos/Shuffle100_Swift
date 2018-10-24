//
//  HomeViewControllerDataSource.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2018/10/06.
//  Copyright © 2018 里 佳史. All rights reserved.
//

import UIKit

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
            func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return [4, 1][section]
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ["設定", "試合開始"][section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeScreenTableCell.identifier) as! UITableViewCell
        
        
        cell.textLabel?.text = ["取り札を用意する歌", "読み上げモード", "初心者モード", "読手"][indexPath.row]
        return cell
    }
    
}

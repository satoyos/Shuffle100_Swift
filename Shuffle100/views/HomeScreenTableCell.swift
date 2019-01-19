//
//  HomeScreenTableCell.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2018/11/04.
//  Copyright © 2018 里 佳史. All rights reserved.
//

import UIKit

class HomeScreenTableCell: UITableViewCell {
    static let identifier = "HomeScreenTableCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(dataSource: DataSource) {
        textLabel?.text = dataSource.title
        accessoryType = dataSource.accessoryType
        detailTextLabel?.text = "aaa"
        self.accessibilityLabel = dataSource.cellLabel
    }
}

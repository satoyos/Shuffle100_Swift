//
//  GameStartCell.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/01/27.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

class GameStartCell: UITableViewCell {
    static let identifier = "GameStartCell"
    var cellStyle: UITableViewCell.CellStyle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        cellStyle = .default
        super.init(style: cellStyle, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func configure(dataSource: TableDataSource) {
        textLabel?.text = dataSource.title
        accessoryType = dataSource.accessoryType
        self.accessibilityLabel = dataSource.accessibilityLabel
        if accessibilityLabel == GameStartCell.identifier {
            textLabel?.textColor = UIColor.red
        }
        textLabel?.textAlignment = .center
    }

}

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
    var cellStyle: UITableViewCell.CellStyle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        cellStyle = .value1
        super.init(style: cellStyle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(dataSource: DataSource) {
        textLabel?.text = dataSource.title
        accessoryType = dataSource.accessoryType
        self.accessibilityLabel = dataSource.accessibilityLabel
        detailTextLabel?.text = dataSource.detailLabelText
        if dataSource.withSwitch {
            let switchView = UISwitch(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            switchView.isOn = dataSource.gameSettings.fakeMode
            self.accessoryView = switchView
        }
    }
}

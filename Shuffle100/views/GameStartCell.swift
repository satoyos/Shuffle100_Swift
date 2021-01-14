//
//  GameStartCell.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/01/27.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

protocol ConfigureButtonTypeCell {
    func configure(dataSource: SettingsCellDataSource)
}

extension ConfigureButtonTypeCell {
    func configure(dataSource: SettingsCellDataSource) {
        
    }
}

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
    

    func configure(dataSource: ButtonTypeCellDataSource) {
        textLabel?.text = dataSource.title
        guard let defaultFont = textLabel?.font else { return }
        accessoryType = dataSource.accessoryType
        self.accessibilityLabel = dataSource.accessibilityLabel
        if accessibilityLabel == GameStartCell.identifier {
            textLabel?.textColor = UIColor.red
            textLabel?.font = UIFont.systemFont(ofSize: defaultFont.pointSize, weight: .bold)
        } else {
            textLabel?.textColor = .label
            textLabel?.font = UIFont.systemFont(ofSize: defaultFont.pointSize, weight: .regular)
        }
        textLabel?.textAlignment = .center
    }

}

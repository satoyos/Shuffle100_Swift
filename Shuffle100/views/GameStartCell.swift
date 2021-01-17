//
//  GameStartCell.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/01/27.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

protocol ConfigureButtonTypeCell {
    func configure(dataSource: ButtonTypeCellDataSource)
}

extension ConfigureButtonTypeCell where Self: UITableViewCell {
    func configure(dataSource: ButtonTypeCellDataSource) {
        var content: UIListContentConfiguration = .cell()
        content.text = dataSource.title

        guard let textProperties = dataSource.textProperties else { return }
        content.textProperties = textProperties
    
        self.contentConfiguration = content
        self.accessibilityLabel = dataSource.accessibilityLabel
    }
}

class GameStartCell: UITableViewCell, ConfigureButtonTypeCell {
//    static let identifier = "GameStartCell"
//    var cellStyle: UITableViewCell.CellStyle
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        cellStyle = .default
//        super.init(style: cellStyle, reuseIdentifier: reuseIdentifier)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}

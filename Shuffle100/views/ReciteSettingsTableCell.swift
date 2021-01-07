//
//  ReciteSettingsTableCell.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/03/16.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

class ReciteSettingsTableCell: UITableViewCell, ConfigureTableCell {
    static let identifier = "ReciteSettingsTableCell"
    var cellStyle: UITableViewCell.CellStyle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        cellStyle = .value1
        super.init(style: cellStyle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

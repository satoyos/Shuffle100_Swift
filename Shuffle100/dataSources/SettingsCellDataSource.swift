//
//  TableDataSource.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2018/10/06.
//  Copyright © 2018 里 佳史. All rights reserved.
//

import UIKit

struct SettingsCellDataSource: TableDataSource {
    var title: String
    var accessoryType: UITableViewCell.AccessoryType
    var accessibilityLabel: String?
    var withSwitchOf: Bool?
    var secondaryText: String
    var configType: UIListContentConfiguration
    
    init(title: String, accessoryType type: UITableViewCell.AccessoryType, secondaryText: String = "", configType: UIListContentConfiguration = .valueCell()) {

        self.title = title
        self.accessoryType = type
        self.configType = configType
        self.secondaryText = secondaryText
    }
}

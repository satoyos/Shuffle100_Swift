//
//  ConfigureTableCellProtocol.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2021/01/07.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import UIKit
import Then

protocol ConfigureSettingTableCell {
    func configure(dataSource: SettingsCellDataSource)
}

extension ConfigureSettingTableCell where Self: UITableViewCell {
    func configure(dataSource: SettingsCellDataSource) {
        var content: UIListContentConfiguration = dataSource.configType
        content.text = dataSource.title
        content.secondaryText = dataSource.secondaryText
        self.contentConfiguration = content
        
        self.accessoryType = dataSource.accessoryType
        self.accessibilityIdentifier = dataSource.title
        self.accessibilityLabel = dataSource.accessibilityLabel
        if let switchValue = dataSource.withSwitchOf {
            let switchView = UISwitch(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            switchView.accessibilityLabel = "modeSwitch"
            switchView.isOn = switchValue
            self.accessoryView = switchView
        } else {
            self.accessoryView = nil
        }
    }
}

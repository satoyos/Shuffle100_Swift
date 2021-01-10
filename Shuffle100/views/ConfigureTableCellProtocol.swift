//
//  ConfigureTableCellProtocol.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2021/01/07.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import UIKit

protocol ConfigureTableCell {
    func configure(dataSource: TableDataSource)
}

extension ConfigureTableCell where Self: UITableViewCell {
    func configure(dataSource: TableDataSource) {
        textLabel?.text = dataSource.title
        accessoryType = dataSource.accessoryType
        self.accessibilityLabel = dataSource.accessibilityLabel
        detailTextLabel?.text = dataSource.secondaryText
        if let switchValue = dataSource.withSwitchOf {
            let switchView = UISwitch(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            switchView.accessibilityLabel = "fakeModeSwitch"
            switchView.isOn = switchValue
            self.accessoryView = switchView
        } else {
            self.accessoryView = nil
        }
    }
}

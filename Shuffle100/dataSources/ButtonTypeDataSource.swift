//
//  ButtonTypeDataSource.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2021/01/16.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import UIKit

struct ButtonTypeCellDataSource: TableDataSource {
    var title: String
    var accessoryType: UITableViewCell.AccessoryType
    var accessibilityLabel: String?
    var textProperties: UIListContentConfiguration.TextProperties?
}

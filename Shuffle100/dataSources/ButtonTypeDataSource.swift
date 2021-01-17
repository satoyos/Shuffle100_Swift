//
//  ButtonTypeDataSource.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2021/01/16.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import UIKit

struct ButtonTypeCellDataSource: TableDataSource {
    enum Color {
        case normal
        case red
    }
    enum FontWeight {
        case normal
        case bold
    }
    var title: String
    var accessoryType: UITableViewCell.AccessoryType
    var accessibilityLabel: String?
    var titleColor: Color = .normal
    var fontWeight: FontWeight = .normal
}

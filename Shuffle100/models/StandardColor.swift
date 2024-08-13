//
//  StandardColor.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/11/16.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

struct StandardColor {
    static let barTintColor = UIColor.dynamicColor(light: SHColor.natsumushi.UIColor, dark: SHColor.momoshiocha.UIColor)
    static let selectedPoemBackColor = UIColor.dynamicColor(light: SHColor.nadeshiko.UIColor, dark: SHColor.koikurenai.UIColor)
    static let standardButtonColor = UIColor.dynamicColor(light: UIColor.systemIndigo, dark: UIColor.systemTeal)
    static let disabledButtonColor = UIColor.dynamicColor(light: .lightGray, dark: .darkGray)
    static let backgroundColor = UIColor.systemBackground
}

//
//  StandardColor.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/11/16.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

struct StandardColor {
    static let barTintColor = UIColor.dynamicColor(light: Color.natsumushi.UIColor, dark: Color.momoshiocha.UIColor)
    static let selectedPoemBackColor = UIColor.dynamicColor(light: Color.nadeshiko.UIColor, dark: Color.koikurenai.UIColor)
    static let standardButtonColor = UIColor.dynamicColor(light: Color.konpeki.UIColor, dark: Color.aofujiiro.UIColor)
    static let disabledButtonColor = UIColor.dynamicColor(light: .lightGray, dark: .darkGray)
    static let backgroundColor = standardBackgroundColor()
    
    static private func standardBackgroundColor() -> UIColor {
        return UIColor.systemBackground
    }
}

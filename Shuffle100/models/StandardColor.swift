//
//  StandardColor.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/11/16.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

struct StandardColor {
    static let barTintColor = UIColor.dynamicColor(light: Color.natsumushi.UIColor, dark: Color.kourainando.UIColor)
    static let selectedPoemBackColor = UIColor.dynamicColor(light: Color.nadeshiko.UIColor, dark: Color.suou.UIColor)
    static let standardButtonColor = UIColor.dynamicColor(light: Color.konpeki.UIColor, dark: Color.aofujiiro.UIColor)
    static let backgroundColor = standardBackgroundColor()
    
    static private func standardBackgroundColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemBackground
        } else {
            return UIColor.white
        }
    }
}

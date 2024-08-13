//
//  UIColorExtention.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2018/09/16.
//  Copyright © 2018年 里 佳史. All rights reserved.
//  Originaly written in [Qiita](https://qiita.com/Kyomesuke3/items/eae6216b13c651254f64)

import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat) {
        let v = hex.map { String($0) } + Array(repeating: "0", count: max(6 - hex.count, 0))
        let r = CGFloat(Int(v[0] + v[1], radix: 16) ?? 0) / 255.0
        let g = CGFloat(Int(v[2] + v[3], radix: 16) ?? 0) / 255.0
        let b = CGFloat(Int(v[4] + v[5], radix: 16) ?? 0) / 255.0
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    convenience init(hex: String) {
        self.init(hex: hex, alpha: 1.0)
    }
    
    /// ライト/ダーク用の色を受け取ってDynamic Colorを作って返す
    public class func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        if #available(iOS 13, *) {
            return UIColor { (traitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return dark
                } else {
                    return light
                }
            }
        }
        return light
    }
}

enum SHColor: String {
    case red = "C85D5D"
    case orange = "DD7C3A"
    case yellow = "D8C05B"
    case green = "66A040"
    case emerald = "5BAA84"
    case lightblue = "63BFC1"
    case blue = "4A78A5"
    case purple = "835C91"
    case pink = "D182B9"
    case brown = "8E6C4D"
    case gray = "828282"
    case black = "3F3F3F"
    case nadeshiko = "eebbcb"
    case natsumushi = "cee4ae"
    case konpeki = "007bbb"
    case shoujouhi = "e2041b"
    case buttonNormal = "0077ff"
    case suou = "9e3d3f"
    case kawairo = "475950"
    case aofujiiro = "84a2d4"
    case tsutsujiiro = "e95295"
    case kourainando = "2c4f54"
    case momoshiocha = "1f3134"
    case koikurenai = "a22041"
    
    var UIColor: UIKit.UIColor {
        return UIKit.UIColor(hex: self.rawValue)
    }
    
    var cgColor: UIKit.CGColor {
        return self.UIColor.cgColor
    }
}

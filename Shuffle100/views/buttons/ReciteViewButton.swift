//
//  ReciteViewButton.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/07/13.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit
// import DSFloatingButton

class ReciteViewButton: DSFloatingButton, SOHGlyphIcon {
    
    fileprivate func standardButtonColor() -> UIColor {
        return StandardColor.standardButtonColor
    }
    
    func configure(height: CGFloat, fontSize: CGFloat, iconType: SOHGlyphIconType) {
        var config = UIButton.Configuration.plain()
        var container = AttributeContainer()
        container.font = UIFont.fontAwesome(ofSize: fontSize, style: .solid)
        config.attributedTitle = AttributedString(stringExpression(of: iconType), attributes: container)
        config.titleAlignment = .automatic
        
        // 次のTransformer設定がなせ必要なのか、不明。
        //  ただ、以下の記事を参考にしたら、本当にフォントがきちんと表示されるようになった。(
        //  https://zenn.dev/tomsan96/articles/ff777c3730dd45
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.fontAwesome(ofSize: fontSize, style: .solid)
            return outgoing
        }
        
        self.configuration = config
        self.cornerRadius = height / 2
        self.useCornerRadius = true
        setGradient()
    }
    
    fileprivate func playButtonGradientStartColor() -> UIColor {
        UIColor.dynamicColor(light: .white, dark: .darkGray)
    }
    
    fileprivate func playButtonGradietEndColor() -> UIColor {
        let lightVersionEndColor = UIColor(displayP3Red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        let darkVersionEndColor = UIColor(displayP3Red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        return UIColor.dynamicColor(light: lightVersionEndColor, dark: darkVersionEndColor)
    }
    
    private func setGradient() {
        // gradient
        self.gradientStartColor = playButtonGradientStartColor()
        self.gradientEndColor = playButtonGradietEndColor()
        self.gradientStartPoint = CGPoint(x: 0.5, y: 0.0)
        self.gradientEndPoint = CGPoint(x: 0.5, y: 1.0)
    }
    
}

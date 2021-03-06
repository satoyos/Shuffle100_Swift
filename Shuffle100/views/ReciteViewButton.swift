//
//  ReciteViewButton.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/07/13.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit
import DSFloatingButton

class ReciteViewButton: DSFloatingButton, SOHGlyphIcon {
    
    fileprivate func standardButtonColor() -> UIColor {
        return StandardColor.standardButtonColor
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setGradient()
    }
    
    func configure(height: CGFloat, fontSize: CGFloat, iconType: SOHGlyphIconType) {
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.font = UIFont.fontAwesome(ofSize: fontSize, style: .solid)
        
        self.setTitleColor(standardButtonColor(), for: .normal)
        self.setTitle(stringExpression(of: iconType), for: .normal)
        self.cornerRadius = height / 2
        self.useCornerRadius = true
        setGradient()
    }
    
    fileprivate func playButtonGradientStartColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.dynamicColor(light: .white, dark: .darkGray)
        } else {
            return .white
        }
    }
    
    fileprivate func playButtonGradietEndColor() -> UIColor {
        let lightVersionEndColor = UIColor(displayP3Red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        let darkVersionEndColor = UIColor(displayP3Red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        if #available(iOS 13.0, *) {
            return UIColor.dynamicColor(light: lightVersionEndColor, dark: darkVersionEndColor)
        } else {
            return lightVersionEndColor
        }
    }
    
    private func setGradient() {
        // gradient
        self.gradientStartColor = playButtonGradientStartColor()
        self.gradientEndColor = playButtonGradietEndColor()
        self.gradientStartPoint = CGPoint(x: 0.5, y: 0.0)
        self.gradientEndPoint = CGPoint(x: 0.5, y: 1.0)
    }
    
}

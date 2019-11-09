//
//  ReciteViewButton.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/07/13.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit
import DSFloatingButton
import FontAwesome_swift

class ReciteViewButton: DSFloatingButton {
    
//    func configure(height: CGFloat, fontSize: CGFloat, iconType: FontAwesome, leftInset: Bool = false) {
    fileprivate func standardButtonColor() -> UIColor {
        return MainCoordinator.standardButtonColor
    }
    
    func configure(height: CGFloat, fontSize: CGFloat, iconType: FontAwesome) {
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.font = UIFont.fontAwesome(ofSize: fontSize, style: .solid)
        
//        self.setTitleColor(Color.konpeki.UIColor, for: .normal)
        self.setTitleColor(standardButtonColor(), for: .normal)
        self.setTitle(String.fontAwesomeIcon(name: iconType), for: .normal)
        self.cornerRadius = height / 2
        self.useCornerRadius = true
        setGradient()
    }
    
    private func setGradient() {
        // gradient
        self.gradientStartColor = UIColor.white
        self.gradientEndColor = UIColor(displayP3Red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        self.gradientStartPoint = CGPoint(x: 0.5, y: 0.0)
        self.gradientEndPoint = CGPoint(x: 0.5, y: 1.0)
    }
}

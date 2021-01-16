//
//  UIButtonExtension.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/07/13.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

extension UIButton {
    func setStandardTitleColor() {
        self.setTitleColor(UIColor(displayP3Red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0), for: .normal)
        self.setTitleColor(UIColor(displayP3Red: 0.0, green: 0.5, blue: 1.0, alpha: 0.3), for: .highlighted)
        self.setTitleColor(StandardColor.disabledButtonColor, for: .disabled)
    }
    
    func setImageWithStarndardColor(_ image: UIImage) {
        self.setImage(image.tint(color: .systemIndigo), for: .normal)
        self.setImage(image.tint(color: .systemIndigo), for: .normal)
    }
}


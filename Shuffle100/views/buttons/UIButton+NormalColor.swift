//
//  UIButton+NormalColor.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/05/11.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
  func setStandardColor() {
    self.setTitleColor(UIColor(displayP3Red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0), for: .normal)
    self.setTitleColor(UIColor(displayP3Red: 0.0, green: 0.5, blue: 1.0, alpha: 0.3), for: .highlighted)
    self.setTitleColor(UIColor.lightGray, for: .disabled)
  }
}

//
//  HandleNavigatorProtocol.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/07/24.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

protocol HandleNavigator {
  func setUpNavigationController(_ nc: UINavigationController) -> Void
  var navigationItemPrompt: String { get }
}

extension HandleNavigator {
  func setUpNavigationController(_ nc: UINavigationController) {
    nc.interactivePopGestureRecognizer?.isEnabled = false
    nc.navigationBar.topItem?.prompt = navigationItemPrompt
    nc.navigationBar.barTintColor = StandardColor.barTintColor
  }
  
  var navigationItemPrompt: String {
    "百首読み上げ"
  }
}


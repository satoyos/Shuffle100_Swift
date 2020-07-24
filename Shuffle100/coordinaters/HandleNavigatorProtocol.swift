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
}

extension HandleNavigator {
    func setUpNavigationController(_ nc: UINavigationController) {
        nc.interactivePopGestureRecognizer?.isEnabled = false
        nc.navigationBar.topItem?.prompt = "百首読み上げ"
        nc.navigationBar.barTintColor = StandardColor.barTintColor
    }
}


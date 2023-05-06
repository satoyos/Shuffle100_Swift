//
//  SelectedPoemsNumberProtocol.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2022/10/14.
//  Copyright © 2022 里 佳史. All rights reserved.
//

import UIKit

protocol SelectedPoemsNumber {
    var selected_num: Int { get }
    var selectedNumBadgeItem: UIBarButtonItem { get }
    func updateBadge()
}

extension SelectedPoemsNumber where Self: SettingsAttachedScreen {
    
    var selected_num: Int {
        settings.state100.selectedNum
    }
    
    var selectedNumBadgeItem: UIBarButtonItem {
        let badgeView = BadgeSwift().then {
            $0.text = "\(selected_num)首"
            $0.insets = CGSize(width: 5, height: 5)
            $0.font = UIFont.preferredFont(forTextStyle: .caption1)
            $0.textColor = .white
            $0.badgeColor = .systemRed
            $0.sizeToFit()
        }
        return UIBarButtonItem(customView: badgeView)
    }
    
    internal func updateBadge() {
        if let numBadgeItem = navigationItem.rightBarButtonItems?.last {
            if let badgeView = numBadgeItem.customView as? BadgeSwift {
                badgeView.setTextWithAnimation("\(selected_num)首")
            }
        }
    }
}

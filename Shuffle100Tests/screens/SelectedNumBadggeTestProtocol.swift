//
//  SelectedNumBadggeTestProtocol.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2022/10/15.
//  Copyright © 2022 里 佳史. All rights reserved.
//

import XCTest
import UIKit

protocol SelectedNumBadgeTest {
    func badgeView(of screen: SettingsAttachedScreen) ->  BadgeSwift?
}

extension SelectedNumBadgeTest {
    func badgeView(of screen: SettingsAttachedScreen) ->  BadgeSwift? {
        guard let badgeView = screen.navigationItem.rightBarButtonItems?.last?.customView as? BadgeSwift else {
            XCTAssert(false, "Could't get BarButtonItem as BadgeSwift View")
            return nil
        }
        return badgeView
    }
}



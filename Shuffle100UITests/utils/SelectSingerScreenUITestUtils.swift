//
//  SelectSingerScreenUITestUtils.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/02/29.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import Foundation
import XCTest

protocol SelectSingerScreenUITestUtils {
    func goBackToHomeScreen(_ app: XCUIApplication) -> Void
}

extension SelectSingerScreenUITestUtils {
    func goBackToHomeScreen(_ app: XCUIApplication) {
        app.navigationBars["読手を選ぶ"].buttons["トップ"].tap()
    }
}

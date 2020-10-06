//
//  NavigateBackToHomeScreen.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/10/05.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

protocol NavigateBackToHomeScreen {
    func goBackToHomeScreen(_ app: XCUIApplication)
}

extension NavigateBackToHomeScreen {
    func goBackToHomeScreen(_ app: XCUIApplication) {
        app.navigationBars["歌を選ぶ"].buttons["トップ"].tap()
    }
}

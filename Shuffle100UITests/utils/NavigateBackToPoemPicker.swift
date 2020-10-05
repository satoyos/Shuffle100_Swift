//
//  NavigateBackToPoemPicker.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/10/05.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

protocol NavigateBackToPoemPicker {
    func goBackToPoemPickerScreen(_ app: XCUIApplication)
}

extension NavigateBackToPoemPicker {
    func goBackToPoemPickerScreen(_ app: XCUIApplication) {
        app.navigationBars.buttons["歌を選ぶ"].tap()
        // then
        XCTAssert(app.navigationBars["歌を選ぶ"].exists)
    }
}

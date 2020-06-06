//
//  PemPickerScreenUITestUtils.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/02/21.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import Foundation
import XCTest

protocol PoemPickerScreenUITestUtils: WaitInUITest {
    func goBackToHomeScreen(_ app: XCUIApplication) -> Void
    func gotoNgramPickerScreenFromPickerScreen(_ app: XCUIApplication)
}

extension PoemPickerScreenUITestUtils {
    func goBackToHomeScreen(_ app: XCUIApplication) {
        app.navigationBars["歌を選ぶ"].buttons["トップ"].tap()
    }
    
    func gotoNgramPickerScreenFromPickerScreen(_ app: XCUIApplication) {
        // given
        let button = waitToHittable(for: app.buttons["まとめて選ぶ"], timeout: 3)
        // when
        button.tap()
        // then
        XCTAssert(app.staticTexts["どうやって選びますか？"].exists)
        // when
        app.buttons["1字目で選ぶ"].tap()
        // then
        waitToAppear(for: app.navigationBars["1字目で選ぶ"], timeout: 5)
    }
}

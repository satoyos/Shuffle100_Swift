//
//  PemPickerScreenUITestUtils.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/02/21.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

protocol PoemPickerScreenUITestUtils: WaitInUITest, NavigateBackToHomeScreen, NavigateBackToPoemPicker {
    func gotoNgramPickerScreenFromPickerScreen(_ app: XCUIApplication)
    func select97Excluding_1_2_4(_ app: XCUIApplication)
}

extension PoemPickerScreenUITestUtils {
    func gotoNgramPickerScreenFromPickerScreen(_ app: XCUIApplication) {
        // given
        let button = waitToHittable(for: app.buttons["まとめて選ぶ"], timeout: timeOutSec)
        // when
        button.tap()
        // then
        XCTAssert(app.staticTexts["どうやって選びますか？"].exists)
        // when
        app.buttons["1字目で選ぶ"].tap()
        // then
        waitToAppear(for: app.navigationBars["1字目で選ぶ"], timeout: 5)
    }
    
    func select97Excluding_1_2_4(_ app: XCUIApplication) {
        let button = waitToHittable(for: app.buttons["全て選択"], timeout: timeOutSec)
        button.tap()
        app.cells["001"].tap()
        app.cells["002"].tap()
        app.cells["004"].tap()
    }

}

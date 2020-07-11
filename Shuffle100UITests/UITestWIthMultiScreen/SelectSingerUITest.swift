//
//  SelectSingerUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/02/13.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class SelectSingerUITest: XCTestCase, HomeScreenUITestUtils, SelectSingerScreenUITestUtils {
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    func test_HomeScreenReflectsSelectedSinger() {
        gotoSelectSingerScreen(app)
        
        XCTContext.runActivity(named: "「いなばくん」を選んでトップ画面に戻ると、その結果が反映されている") { (acitivity) in
            // given
            let inabaLabel = "いなばくん（人間）"
            // when
            selectSingerFor(name: "いなばくん", in: app)
            goBackToHomeScreen(app)
            // then
            XCTAssertTrue(app.cells.staticTexts[inabaLabel].exists)
        }
    }

    func test_canGoToSelectSingerScreenWhenBeginnerMode() {
        XCTContext.runActivity(named: "初心者モードに設定する") { _ in
            // given
            gotoSelectModeScreen(app)
            // then
            app.pickerWheels.element.adjust(toPickerWheelValue: "初心者 (チラし取り)")
            // when
            app.buttons["トップ"].tap()
            // then
            XCTAssert(app.cells.staticTexts["初心者"].exists)
            XCTAssertFalse(app.cells["空札を加える"].exists)
        }
        // when
        gotoSelectSingerScreen(app)
    }
}

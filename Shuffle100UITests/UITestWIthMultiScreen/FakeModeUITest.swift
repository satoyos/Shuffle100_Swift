//
//  FakeModeUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/02/23.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class FakeModeUITest: XCTestCase, HomeScreenUITestUtils, PoemPickerScreenUITestUtils, RecitePoemScreenUITestUtils {
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    func test_fakeModeMakeDeckSize_x_2() {
        gotoPoemPickerScreen(app)
        XCTContext.runActivity(named: "2首選んでホーム画面に戻る") { (acitivity) in
            // given
            sleep(1)
            app.buttons["全て取消"].tap()
            app.tables.cells["001"].tap()
            app.tables.cells["003"].tap()
            // when
            goBackToHomeScreen(app)
            // then
            XCTAssert(app.staticTexts["2首"].exists)
        }
        XCTContext.runActivity(named: "空札モードにしてゲームを開始すると、読み上げる枚数が倍になっている。") { (acitivity) in
            // when
            app.tables.switches["modeSwitch"].tap()
            gotoRecitePoemScreen(app)
            tapForwardButton(app)
            // then
            XCTAssert(app.staticTexts["1首め:上の句 (全4首)"].exists)
        }
    }
}

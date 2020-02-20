//
//  PoemPickerScreenUITest.swift
//  Shuffle100UITests
//
//  Created by 里 佳史 on 2019/12/14.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

class PoemPickerScreenUITest: XCTestCase, HomeScreenUITestUtils, SetEnvUITestUtils {
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        setEnvIgnoreSavedData(app)
        app.launch()
    }

    func test_cancelAllAndSelectAll() {
        XCTContext.runActivity(named: "「全て取消」ボタンを押すと、選ばれている歌が0首になる") { activity in
            // given
            gotoPoemPickerScreen(app)
            // when
            sleep(1)
            app.buttons["全て取消"].tap()
            app.navigationBars["歌を選ぶ"].buttons["トップ"].tap()
            // then
            XCTAssertTrue(app.cells.staticTexts["0首"].exists)
        }
        XCTContext.runActivity(named: "そこから「全て選択」ボタンを押すと、選ばれている歌が100首になる") { activity in
            // given
            gotoPoemPickerScreen(app)
            // when
            sleep(1)
            app.buttons["全て選択"].tap()
            app.navigationBars["歌を選ぶ"].buttons["トップ"].tap()
            // then
            XCTAssertTrue(app.cells.staticTexts["100首"].exists)
        }
    }
}

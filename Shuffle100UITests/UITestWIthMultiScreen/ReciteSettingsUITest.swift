//
//  ReciteSettingsUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/03/02.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class ReciteSettingsUITest: XCTestCase, HomeScreenUITestUtils {
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_IntervalSetting() {
        // given, when
        gotoReciteSettingsScreen(app)
        // then
        app.tables.staticTexts["歌と歌の間隔"].tap()
        // then
        XCTAssert(app.navigationBars["歌の間隔の調整"].exists)
        
        if #available(iOS 13.0, *) {
            XCTContext.runActivity(named: "スライダーを左端に動かすと、ラベルの値は下限値になる"){ action in
                // when
                app.sliders["slider"].adjust(toNormalizedSliderPosition: 0.0)
                // then
                XCTAssert(app.staticTexts["0.50"].exists)
            }
            XCTContext.runActivity(named: "「いろいろな設定」画面に戻ると、「歌と詩の間隔」の値が書き換わっている") { action in
                // when
                app.navigationBars.buttons["いろいろな設定"].tap()
                // then
                XCTAssert(app.staticTexts["0.50"].exists)
            }
        }
    }
}

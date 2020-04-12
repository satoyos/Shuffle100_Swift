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
        XCTAssertFalse(app.staticTexts["トップ"].exists)
        
        if #available(iOS 13.0, *) {
            XCTContext.runActivity(named: "スライダーを左端に動かすと、ラベルの値は下限値になる"){ action in
                // when
                app.sliders["slider"].adjust(toNormalizedSliderPosition: 0.0)
                // then
                XCTAssert(app.staticTexts["0.50"].exists)
            }
            XCTContext.runActivity(named: "「試しに聞いてみる」ボタンを押すと、1秒後にはラベルの値が0.00になっている") { activity in
                app.buttons["試しに聞いてみる"].tap()
                waitToAppear(for: app.staticTexts["0.00"], timeout: 10)

            }
            XCTContext.runActivity(named: "「いろいろな設定」画面に戻ると、「歌と詩の間隔」の値が書き換わっている") { action in
                // when
                app.navigationBars.buttons["いろいろな設定"].tap()
                // then
                XCTAssert(app.staticTexts["0.50"].exists)
            }
            XCTContext.runActivity(named: "設定終了ボタンを押すと、ホーム画面に戻る") { activity in
                // when
                app.buttons["設定終了"].tap()
                // then
                XCTAssert(app.navigationBars.staticTexts["トップ"].exists)
            }
        }
    }
}


//
//  ReciteSettingsUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/03/02.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class ReciteSettingsUITest: XCTestCase, HomeScreenUITestUtils, RecitePoemScreenUITestUtils, ExitGameUITestUtils {
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
        // slider adjsutment doesn't work well on iOS 13.4 SImulator
        if UIDevice.current.userInterfaceIdiom == .pad { return }
        // given, when
        gotoReciteSettingsScreen(app)
        // then
        app.tables.staticTexts["歌と歌の間隔"].tap()
        // then
        XCTAssert(app.navigationBars["歌の間隔の調整"].exists)
        XCTAssertFalse(app.staticTexts["トップ"].exists)
        
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
    
    func test_KamiShimoIntervalSetting() {
        // slider adjsutment doesn't work well on iOS 13.4 SImulator
        if UIDevice.current.userInterfaceIdiom == .pad { return }
        // given, when
        gotoReciteSettingsScreen(app)
        // when
        app.tables.staticTexts["上の句と下の句の間隔"].tap()
        // then
        XCTAssert(app.navigationBars["上の句と下の句の間隔"].exists)
        XCTAssertFalse(app.staticTexts["トップ"].exists)

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
        XCTContext.runActivity(named: "「いろいろな設定」画面に戻ると、「上の句と下の句の間隔」の値が書き換わっている") { action in
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
    
    func test_VolumeSetting() {
        // given, when
        gotoReciteSettingsScreen(app)
        // then
        XCTAssert(app.staticTexts["100%"].exists)
        // when
        app.tables.staticTexts["音量調整"].tap()
        // then
        XCTAssert(app.staticTexts["音量の調整"].exists)
        
        XCTContext.runActivity(named: "スライダーを左端に動かして、元の画面に戻ると、音量が「0%」になっている"){ action in
            // when
            app.sliders["slider"].adjust(toNormalizedSliderPosition: 0.0)
            app.buttons["いろいろな設定"].tap()
            // then
            XCTAssert(app.cells.staticTexts["0%"].exists)
        }
    }
    
    func test_openSettingsFromRecitePoemScreen() {
        // given
        gotoRecitePoemScreen(app)
        // then
        let gearButton = app.buttons["gear"]
        XCTAssert(gearButton.exists)
        
        XCTContext.runActivity(named: "歯車ボタンをタップすると、「いろいろな設定」画面が現れる") { activity in
            // when
            gearButton.tap()
            // then
            XCTAssert(app.navigationBars.staticTexts["いろいろな設定"].exists)
        }
        
        XCTContext.runActivity(named: "上の句と下の句の間隔をMaxにしてホーム画面に戻ると、その値が反映されている") { activity in
            // when
            app.tables.staticTexts["歌と歌の間隔"].tap()
            app.sliders["slider"].adjust(toNormalizedSliderPosition: 1.0)
            // then
            XCTAssert(app.staticTexts["2.00"].exists)
            // when
            app.navigationBars.buttons["いろいろな設定"].tap()
            // then
            XCTAssert(app.staticTexts["2.00"].exists)
            // when
            app.buttons["設定終了"].tap()
            // then
            XCTAssert(app.staticTexts["序歌"].exists)
            // when
            app.buttons["exit"].tap()
            app.buttons["終了する"].tap()
            // then
            waitToAppear(for: app.navigationBars.staticTexts["トップ"], timeout: 4)
            // when
            gotoReciteSettingsScreen(app)
            // then
            XCTAssert(app.staticTexts["2.00"].exists)
        }
    }

    func test_openSettingsFromWhatsNextScreen() {
        // given
        gotoWhatsNextScreen(app)
        // then
        let gearButton = app.buttons["gear"]
        XCTAssert(gearButton.exists)
        
        XCTContext.runActivity(named: "歯車ボタンをタップすると、「いろいろな設定」画面が現れる") { activity in
            // when
            gearButton.tap()
            // then
            XCTAssert(app.navigationBars.staticTexts["いろいろな設定"].exists)
        }
        
        XCTContext.runActivity(named: "上の句と下の句の間隔をMaxにしてホーム画面に戻ると、その値が反映されている") { activity in
            // when
            app.tables.staticTexts["歌と歌の間隔"].tap()
            app.sliders["slider"].adjust(toNormalizedSliderPosition: 1.0)
            // then
            XCTAssert(app.staticTexts["2.00"].exists)
            // when
            app.navigationBars.buttons["いろいろな設定"].tap()
            // then
            XCTAssert(app.staticTexts["2.00"].exists)
            // when
            app.buttons["設定終了"].tap()
            // then
            XCTAssert(app.staticTexts["次はどうする？"].exists)
            // when
            exitGameSuccessfully(app)
            // when
            gotoReciteSettingsScreen(app)
            // then
            XCTAssert(app.staticTexts["2.00"].exists)
        }
    }
}


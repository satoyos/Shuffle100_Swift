//
//  ReciteSettingsUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/03/02.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class ReciteSettingsUITest: XCTestCase, HomeScreenUITestUtils, RecitePoemScreenUITestUtils, ExitGameUITestUtils, AdjustWithSliderUtils {
    let app = XCUIApplication()
    lazy var homePage = HomePage(app: app)

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
        // when
        let settingsPage = homePage.gotoReciteSettingPage()
        // then
        XCTAssert(settingsPage.exists, "「いろいろな設定」画面に到達")
        // when
        let intervalSettingPage = settingsPage.gotoIntervalSettingPage()
        // then
        XCTAssert(intervalSettingPage.exists, "「歌と歌の間隔」設定画面に到達")
        XCTAssertFalse(homePage.exists)
        // when
        intervalSettingPage.adjustSliderToLeftLimit()
        // then
        XCTAssert(intervalSettingPage.staticDigitTextExists(around: 0.50))
        // when
        intervalSettingPage.tryButton.tap()
        // then
        waitToAppear(for: intervalSettingPage.zeroSecLabel, timeout: 10)
        // when
        intervalSettingPage.backToAllSettingsButton.tap()
        // then
        XCTAssert(settingsPage.staticDigitTextExists(around: 0.50))
        // when
        settingsPage.exitSettingsButton.tap()
        // then
        XCTAssert(homePage.exists, "トップページに戻ってくる")
    }
    
    func test_KamiShimoIntervalSetting() {
        // given
        let settingsPage = homePage.gotoReciteSettingPage()
        // when
        let kamiShimoIntervalPage = settingsPage.gotoKamiShimoIntervalPage()
        // then
        XCTAssert(kamiShimoIntervalPage.exists, "上の句と下の句の間隔調整ページに到達")
        XCTAssertFalse(homePage.exists)
        // when
        kamiShimoIntervalPage.adjustSliderToLeftLimit()
        // then
        XCTAssert(kamiShimoIntervalPage.staticDigitTextExists(around: 0.50))
        // when
        kamiShimoIntervalPage.tryButton.tap()
        // then
        waitToAppear(for: kamiShimoIntervalPage.zeroSecLabel, timeout: 10)
        // when
        kamiShimoIntervalPage.backToAllSettingsButton.tap()
        // then
        XCTAssert(settingsPage.staticDigitTextExists(around: 0.50))
        // when
        settingsPage.exitSettingsButton.tap()
        // then
        XCTAssert(homePage.exists, "トップページに戻ってくる")
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
        gotoRecitePoemScreen()
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
            staticDigitTextExistAround(2.00, in: app)
            // when
            app.navigationBars.buttons["いろいろな設定"].tap()
            // then
            staticDigitTextExistAround(2.00, in: app)
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
            staticDigitTextExistAround(2.00, in: app)
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
            staticDigitTextExistAround(2.00, in: app)
            // when
            app.buttons["設定終了"].tap()
            // then
            XCTAssert(app.staticTexts["次はどうする？"].exists)
            // when
            exitGameSuccessfully(app)
            // when
            gotoReciteSettingsScreen(app)
            // then
            staticDigitTextExistAround(2.00, in: app)
        }
    }
}


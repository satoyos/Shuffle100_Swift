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
        let settingsPage = homePage.gotoReciteSettingPage()
        // then
        XCTAssert(settingsPage.fullVolumeLabel.exists)
        // when
        let volumePage = settingsPage.gotoVolumePage()
        // then
        XCTAssert(volumePage.exists, "音量調整のページに到達")
        // when
        volumePage
            .adjustSliderToLeftLimit()
            .backToAllSettingsButton.tap()
        // then
        XCTAssert(settingsPage.zeroVolumeLabel.exists)
    }
    
    func test_openSettingsFromRecitePoemScreen() {
        let recitePage = homePage.gotoRecitePoemPage()
        // when
        let settingsPage = recitePage.gotoSettingsPage()
        // then
        XCTAssert(settingsPage.exists)
        // when
        let kamiShimoPage = settingsPage.gotoKamiShimoIntervalPage()
        // then
        XCTAssert(kamiShimoPage.exists)
        // when
        kamiShimoPage
            .adjustSliderToRightLimit()
            .backToAllSettingsButton.tap()
        // then
        XCTAssert(settingsPage.maxIntarvalLabel.exists)
        // when
        settingsPage.exitSettingsButton.tap()
        // then
        XCTAssert(recitePage.jokaTitle.exists, "序歌の読み上げ画面に戻る")
        // when
        recitePage
            .popUpExitGameAlert()
            .confirmButton.tap()
        // then
        waitToAppear(for: homePage.pageTitle, timeout: timeOutSec)
        // when
        let newSettingsPage = homePage.gotoReciteSettingPage()
        // then
        XCTAssert(newSettingsPage.maxIntarvalLabel.exists, "事前に設定した間隔が表示される")
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


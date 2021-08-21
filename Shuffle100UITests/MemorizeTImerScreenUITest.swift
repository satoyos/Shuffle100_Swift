//
//  MemorizeTImerScreenUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/08/08.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class MemorizeTImerScreenUITest: XCTestCase, SOHGlyphIcon {
    internal let app = XCUIApplication()
    internal lazy var homePage = HomePage(app: app)

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    func test_showTimerScreen() throws {
        // when
        let timerPage = homePage.gotoMemorizeTimerPage()
        // then
        XCTAssert(timerPage.exists, "暗記時間タイマー画面に到達")
    }
    
    func test_tapPlayButtonToStartCountDown() {
        // when
        let timerPage = homePage.gotoMemorizeTimerPage()
        // then
        XCTAssert(timerPage.timeIsInitialValue)
        // when
        timerPage.buttonToPlay.tap()
        // then
        XCTAssert(timerPage.buttonToPause.exists, "ボタンの表示がPause待ちに変わる")
        // when
        sleep(1)
        // then
        XCTAssertFalse(timerPage.timeIsInitialValue, "カウントダウンが始まる")
        XCTContext.runActivity(named: "もう一度playButtonをタップすると、ボタンの表示がPlay待ちに変わる") { _ in
            // when
            timerPage.buttonToPause.tap()
            // then
            XCTAssert(timerPage.buttonToPlay.exists)
        }
    }
    
    func test_goThroughMemorizeTime() {
        // when
        let timerPage = homePage.gotoMemorizeTimerPage()
        timerPage.buttonToPlay.tap()
        sleep(15 * 60 + 5)
        // then
        XCTAssert(homePage.exists, "暗記時間が終わると、自動的にトップ画面に戻る")
    }
}

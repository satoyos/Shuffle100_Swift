//
//  MemorizeTImerScreenUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/08/08.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class MemorizeTImerScreenUITest: XCTestCase, SOHGlyphIcon {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    func test_showTimerScreen() throws {
        gotoMemorizeTimerScreen()
        XCTAssert(app.buttons.staticTexts[stringExpression(of: .play)].exists)
    }
    
    func test_tapPlayButtonToStartCountDown() {
        // given
        gotoMemorizeTimerScreen()
        XCTAssert(app.staticTexts["15"].exists)
        // when
        app.buttons.staticTexts[stringExpression(of: .play)].tap()
        // then
        XCTAssert(app.buttons.staticTexts[stringExpression(of: .pause)].exists)
        sleep(1)
        XCTAssertFalse(app.staticTexts["15"].exists)
        XCTContext.runActivity(named: "もう一度playButtonをタップすると、ボタンの表示がpauseに変わる") { _ in
            app.buttons.staticTexts[stringExpression(of: .pause)].tap()
            // then
            XCTAssert(app.buttons.staticTexts[stringExpression(of: .play)].exists)
        }
    }
    
    func test_goThroughMemorizeTime() {
        // given
        gotoMemorizeTimerScreen()
        // when
        app.buttons.staticTexts[stringExpression(of: .play)].tap()
        // then
        XCTContext.runActivity(named: "暗記時間が終わると、自動的にトップ画面に戻る") { _ in
            sleep(15 * 60)
            waitToAppear(for: app.navigationBars["トップ"], timeout: 10)
        }
    }
    
    private func gotoMemorizeTimerScreen() {
        // when
        app.tables.staticTexts["暗記時間タイマー"].tap()
        // then
        XCTAssert(app.navigationBars["暗記時間タイマー"].exists)
    }

}

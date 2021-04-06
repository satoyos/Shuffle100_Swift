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
        gotoPoemPickerScreen()
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
//            app.tables.switches["modeSwitch"].tap()
            turnOnFakeMode()
            gotoRecitePoemScreen(app)
            tapForwardButton(app)
            // then
            XCTAssert(app.staticTexts["1首め:上の句 (全4首)"].exists)
        }
    }
    
    func test_fakeModeShouldBeCanceldWhenChangingReciteModeFromNormal() {
        // given
        test_fakeModeMakeDeckSize_x_2()
        XCTContext.runActivity(named: "試合を中断して、トップ画面に戻る") { _ in
            // when
            app.buttons["exit"].tap()
            app.alerts.buttons["終了する"].tap()
            // then
            waitToAppear(for: app.navigationBars.staticTexts["トップ"], timeout: timeOutSec)
        }
        // when
        XCTContext.runActivity(named: "読み上げモードを「初心者」に変更する") { _ in
            gotoSelectModeScreen(app)
            app.pickerWheels.element.adjust(toPickerWheelValue: "初心者 (チラし取り)")
            app.buttons["トップ"].tap()
            // then
            XCTAssert(app.cells.staticTexts["初心者"].exists)
        }
        // then
        XCTContext.runActivity(named: "読み上げる枚数が2枚に変わっている") { _ in
            // when
            gotoRecitePoemScreen(app)
            tapForwardButton(app)
            // then
            XCTAssert(app.staticTexts["1首め:上の句 (全2首)"].exists)
        }
    }
    
    private func turnOnFakeMode() {
        app.tables.switches["modeSwitch"].tap()
    }
    
    
}

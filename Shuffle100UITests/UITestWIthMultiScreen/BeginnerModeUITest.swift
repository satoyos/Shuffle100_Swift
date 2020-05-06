//
//  BeginnerModeUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/04/27.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class BeginnerModeUITest: XCTestCase, HomeScreenUITestUtils, RecitePoemScreenUITestUtils, PoemPickerScreenUITestUtils, ExitGameUITestUtils {
    var app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_startBeginnerMode() throws {
        gotoWhatsNextScreen(app)
    }
    
    func test_showTorifuda() {
        // given
        XCTContext.runActivity(named: "歌を1首(#4)だけ選んだ状態にする") { (activity) in
            gotoPoemPickerScreen(app)
            let clearButton = waitToHittable(for: app.buttons["全て取消"])
            clearButton.tap()
            //   tap poems #4
            app.tables.cells["004"].tap()
            //   back to HomeScreen
            goBackToHomeScreen(app)
            // then
            XCTAssertTrue(app.cells.staticTexts["1首"].exists)
        }
        gotoWhatsNextScreen(app, poemsNumber: 1)
        // when
        app.buttons["torifuda"].tap()
        // then
        XCTAssert(app.images["fudaView"].exists)
        XCTAssert(app.staticTexts["ふ"].exists)
        XCTAssert(app.staticTexts["し"].exists)
        XCTAssertFalse(app.staticTexts["あ"].exists)
    }
    
    func test_refrainShimo() {
        // given
        gotoWhatsNextScreen(app)
        // when
        app.buttons["refrain"].tap()
        // then
        XCTContext.runActivity(named: "読み上げ画面に戻る") { activity in
            XCTAssert(app.staticTexts["1首め:下の句 (全100首)"].exists)
        }
        XCTContext.runActivity(named: "そのまま下の句の読み上げが終わると、再び「次はどうする？」画面が現れる") { activity in
            waitToAppear(for: app.staticTexts["次はどうする？"], timeout: 15)
        }
    }
    
    func test_goNext() {
        // given
        gotoWhatsNextScreen(app)
        // when
        app.buttons["goNext"].tap()
        // then
        XCTContext.runActivity(named: "そのまま2首めに移る") { activity in
            waitToAppear(for: app.staticTexts["2首め:上の句 (全100首)"], timeout: 3)
        }
    }
    
    func test_exitGameFromWhatsNextScreen() {
        // given
        gotoWhatsNextScreen(app)
        // when, then
        exitGameSuccessfully(app)
    }
    
}

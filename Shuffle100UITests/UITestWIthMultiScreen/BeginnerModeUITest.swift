//
//  BeginnerModeUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/04/27.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class BeginnerModeUITest: XCTestCase, HomeScreenUITestUtils, RecitePoemScreenUITestUtils, PoemPickerScreenUITestUtils {
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
        gotoWhatsNextScreen()
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
        gotoWhatsNextScreen(poemsNumber: 1)
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
        gotoWhatsNextScreen()
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
        gotoWhatsNextScreen()
        // when
        app.buttons["goNext"].tap()
        // then
        XCTContext.runActivity(named: "そのまま2首めに移る") { activity in
            waitToAppear(for: app.staticTexts["2首め:上の句 (全100首)"], timeout: 3)
        }
    }
    
    private func gotoWhatsNextScreen(poemsNumber:Int = 100) {
        XCTContext.runActivity(named: "初心者モードを選択") { (activity) in
            // when
            gotoSelectModeScreen(app)
            app.pickerWheels.element.adjust(toPickerWheelValue: "初心者 (チラし取り)")
            app.buttons["トップ"].tap()
            // then
            XCTAssert(app.cells.staticTexts["初心者"].exists)
        }
        XCTContext.runActivity(named: "そして序歌へ") { (activity) in
            gotoRecitePoemScreen(app)
        }
        XCTContext.runActivity(named: "forwardボタンを押すと、1首めの上の句へ") { (activity) in
            tapForwardButton(app)
            XCTAssert(app.staticTexts["1首め:上の句 (全\(poemsNumber)首)"].exists)
        }
        XCTContext.runActivity(named: "上の句の読み上げ後、自動的に下の句へ") { (activity) in
            
            tapForwardButton(app)
            XCTAssert(app.staticTexts["1首め:下の句 (全\(poemsNumber)首)"].exists)
        }
        XCTContext.runActivity(named: "下の句が終わると、「次はどうする？」画面が現れる") { (activity) in
            
            tapForwardButton(app)
            XCTAssert(app.staticTexts["次はどうする？"].exists)
        }
    }
    


}

//
//  BeginnerModeUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/04/27.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class BeginnerModeUITest: XCTestCase, HomeScreenUITestUtils, RecitePoemScreenUITestUtils {
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
        XCTContext.runActivity(named: "初心者モードを選択") { (activiti) in
            // when
            gotoSelectModeScreen(app)
            app.pickerWheels.element.adjust(toPickerWheelValue: "初心者 (チラし取り)")
            app.buttons["トップ"].tap()
            // then
            XCTAssert(app.cells.staticTexts["初心者"].exists)
        }
        XCTContext.runActivity(named: "そして序歌へ") { (activiti) in
            gotoRecitePoemScreen(app)
        }
        XCTContext.runActivity(named: "forwardボタンを押すと、1首めの上の句へ") { (activiti) in
            tapForwardButton(app)
            XCTAssert(app.staticTexts["1首め:上の句 (全100首)"].exists)
        }
        XCTContext.runActivity(named: "上の句の読み上げ後、自動的に下の句へ") { (activiti) in
            
            tapForwardButton(app)
            XCTAssert(app.staticTexts["1首め:下の句 (全100首)"].exists)
        }
    }

}

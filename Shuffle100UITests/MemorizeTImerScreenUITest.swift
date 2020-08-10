//
//  MemorizeTImerScreenUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/08/08.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest
import FontAwesome_swift

class MemorizeTImerScreenUITest: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    func test_showTimerScreen() throws {
        // when
        app.tables.staticTexts["暗記時間タイマー"].tap()
        // then
        XCTAssert(app.navigationBars["暗記時間タイマー"].exists)
        XCTAssert(app.buttons.staticTexts[String.fontAwesomeIcon(name: .play)].exists)
    }

}

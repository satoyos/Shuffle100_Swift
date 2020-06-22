//
//  HelpListUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/06/22.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class HelpListUITest: XCTestCase {

    private var app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    func test_gotoHelpListScreen() throws {
        // when
        app.buttons["HelpButton"].tap()
        // then
        XCTAssert(app.navigationBars["ヘルプ"].exists)
    }

}

//
//  NgramPickerUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/05/06.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class NgramPickerUITest: XCTestCase, HomeScreenUITestUtils {
    var app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_openNgramPicker() throws {
        // given
        gotoPoemPickerScreen(app)
        // when
        let button = waitToHittable(for: app.buttons["まとめて選ぶ"], timeout: 3)
        button.tap()
        // then
        XCTAssert(app.staticTexts["どうやって選びますか？"].exists)
        // when
        app.buttons["1字目で選ぶ"].tap()
        // then
        waitToAppear(for: app.navigationBars["1字目で選ぶ"], timeout: 1)
    }

}

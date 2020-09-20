//
//  FiveColorsPickerUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/09/09.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class FiveColorsPickerUITest: XCTestCase, HomeScreenUITestUtils, PoemPickerScreenUITestUtils {

    private var app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_selectByGroupActionsIncludsActionFor5Colors() throws {
        // given
        gotoPoemPickerScreen(app)
        // when
        let button = waitToHittable(for: app.toolbars.buttons["まとめて選ぶ"], timeout: 3)
        button.tap()
        // then
        XCTAssert(app.buttons["1字目で選ぶ"].exists)
        
        // 五色百人一首機能の追加は、Version 6.2になる予定。
        //        XCTAssert(app.buttons["五色百人一首の色で選ぶ"].exists)
        XCTContext.runActivity(named: "Version 6.1.1(iOS14の動作確認リリース)では、五色百人一首機能はまだ隠す") { _ in
            XCTAssertFalse(app.buttons["五色百人一首の色で選ぶ"].exists)
        }
    }

}

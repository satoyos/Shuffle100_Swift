//
//  SelectReciteModeUITest.swift
//  Shuffle100UITests
//
//  Created by 里 佳史 on 2019/03/03.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

class SelectReciteModeUITest: XCTestCase, HomeScreenUITestUtils {
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_HomeScreenReflectsSelectedMode() {
        let modePage = homePage.gotoSelectModePage()
        // then
        XCTAssert(modePage.exists, "モード選択画面に到達")
        
        XCTContext.runActivity(named: "初心者モードを選んでトップ画面に戻ると、その結果が反映されている") { (acitivity) in
            // when
            modePage
                .selectMode(.beginner)
                .backToTopButton.tap()
            // then
            XCTAssert(homePage.reciteModeIs(.beginner))
            // in BeginnerMode, fake mode cell should disappear
            XCTAssertFalse(homePage.fakeModeCell.exists)
        }
    }
}

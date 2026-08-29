//
//  SelectReciteModeUITest.swift
//  Shuffle100UITests
//
//  Created by 里 佳史 on 2019/03/03.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

class SelectReciteModeUITest: XCTestCase {
    let app = XCUIApplication()
    lazy var homePage = HomePage(app: app)
    
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
        XCTContext.runActivity(named: "初心者モードを選んでトップ画面に戻ると、その結果が反映されている") { (acitivity) in
            // when
            homePage.selectReciteMode(.beginner)
            // then
            XCTAssert(homePage.reciteModeIs(.beginner))
            // in BeginnerMode, fake mode cell should disappear
            XCTAssertFalse(homePage.fakeModeCell.exists)
        }
    }

    func test_HomeScreenReflectsSelectedNonstopShimoMode() {
        XCTContext.runActivity(named: "下の句のみのノンストップモードを選択できる") { _ in
            homePage.selectReciteMode(.nonstopShimo)

            XCTAssertTrue(homePage.reciteModeIs(.nonstopShimo))
            XCTAssertTrue(homePage.fakeModeCell.exists)
        }
    }
    
}

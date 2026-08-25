//
//  SelectSingerUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/02/13.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class SelectSingerUITest: XCTestCase {
    let app = XCUIApplication()
    lazy var homePage = HomePage(app: app)
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    func test_HomeScreenReflectsSelectedSinger() {
        XCTContext.runActivity(named: "「IA」を選ぶと、その結果が反映されている") { (acitivity) in
            // when
            homePage.selectSinger(.ia)
            // then
            XCTAssert(homePage.singerIs(.ia))
        }
    }

    func test_canGoToSelectSingerScreenWhenBeginnerMode() {
        XCTContext.runActivity(named: "初心者モードに設定すると、空札設定セルが表示されなくなる") { _ in
            // given
            // when
            homePage.selectReciteMode(.beginner)
            // then
            XCTAssert(homePage.reciteModeIs(.beginner))
            XCTAssertFalse(homePage.fakeModeCell.exists)
        }
    }
}

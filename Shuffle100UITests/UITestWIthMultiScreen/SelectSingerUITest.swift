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
        let selectSingerPage = homePage.gotoSelectSingerPage()
        
        XCTContext.runActivity(named: "「いなばくん」を選んでトップ画面に戻ると、その結果が反映されている") { (acitivity) in
            // when
            selectSingerPage
                .selectSingerFor(name: "いなばくん")
                .backToTopButton.tap()
            // then
            XCTAssert(homePage.singerIs(.inaba))
        }
    }

    func test_canGoToSelectSingerScreenWhenBeginnerMode() {
        XCTContext.runActivity(named: "初心者モードに設定すると、空札設定セルが表示されなくなる") { _ in
            // given
            let selectModePage = homePage.gotoSelectModePage()
            // when
            selectModePage
                .selectMode(.beginner)
                .backToTopButton.tap()
            // then
            XCTAssert(homePage.reciteModeIs(.beginner))
            XCTAssertFalse(homePage.fakeModeCell.exists)
        }
    }
}

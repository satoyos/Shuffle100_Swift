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
    
    // 下の句かるたは、Ver.7までおあずけ
//    func test_reciteModeSupports_HokkaidoMode() {
//        // when
//        let modePage = homePage.gotoSelectModePage()
//        // then
//        XCTAssert(modePage.exists)
//
//        XCTContext.runActivity(named: "下の句かるたモードを選んでトップ画面に戻ると、その結果が反映されている") { _ in
//            // when
//            modePage
//                .selectMode(.hokkaido)
//                .backToTopButton.tap()
//            // then
//            XCTAssert(homePage.reciteModeIs(.hokkaido))
//        }
//    }
}

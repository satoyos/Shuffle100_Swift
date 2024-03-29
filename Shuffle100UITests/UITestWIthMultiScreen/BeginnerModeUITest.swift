//
//  BeginnerModeUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/04/27.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class BeginnerModeUITest: XCTestCase, OnWhatsNextScreenTest {
    var app = XCUIApplication()
    lazy var homePage = HomePage(app: app)

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()

    }

    func test_startBeginnerMode() throws {
        // when
        let whatsNextPage = homePage.skipToWhatsNextPage()
        // then
        XCTAssert(whatsNextPage.exists)
    }
    
    func test_showTorifuda() {
        showTorifudaTest(mode: .beginner)
    }
    
    func test_refrainShimo() {
        refrainShimoTest(mode: .beginner)
    }
    
    func test_goNext() {
        goNextTest()
    }
    
    func goNextTest() {
        // when
        let whatsNextPage = homePage.skipToWhatsNextPage(mode: .beginner)
        whatsNextPage.nextPoemButton.tap()
        // then
        let recitePage = RecitePoemPage(app: app)
        XCTAssert(recitePage.isReciting(number: 2, side: .kami))
    }
    
    func test_exitGameFromWhatsNextScreen() {
        // when
        let whatsNextPage = homePage.skipToWhatsNextPage()
        whatsNextPage.exitButton.tap()
        // then
        let exitAlert = ExitGameDialog(app: app)
        XCTAssert(exitAlert.exists, "確認ダイアログが現れる")
        // when
        exitAlert.confirmButton.tap()
        // then
        XCTAssert(homePage.exists, "トップ画面に戻る")
    }
}

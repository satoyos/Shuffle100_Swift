//
//  FakeModeUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/02/23.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class FakeModeUITest: XCTestCase {
    let app = XCUIApplication()
    lazy var homePage = HomePage(app: app)

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    func test_fakeModeMakeDeckSize_x_2() {
        // when
        let pickerPage = homePage.goToPoemPickerPage()
        // then
        XCTAssert(pickerPage.exists)
        // when
        pickerPage.cancelAllButton.tap()
        pickerPage
            .tapCellof(number: 1)
            .tapCellof(number: 3)
            .backToTopButton.tap()
        // then
        XCTAssert(homePage.numberOfSelecttedPoems(is: 2))
        XCTContext.runActivity(named: "空札モードにしてゲームを開始すると、読み上げる枚数が倍になっている。") { (acitivity) in
            // when
            homePage.fakeModeSwitch.tap()
            let recitePage = homePage.gotoRecitePoemPage()
            recitePage.tapForwardButton()
            // then
            XCTAssert(recitePage.isReciting(number: 1, side: .kami, total: 4))
        }
    }
    
    func test_fakeModeShouldBeCanceldWhenChangingReciteModeFromNormal() {
        // given
        let recitePage = RecitePoemPage(app: app)
        test_fakeModeMakeDeckSize_x_2()
        
        XCTContext.runActivity(named: "試合を中断して、トップ画面に戻る") { _ in
            // when
            let alert = recitePage.popUpExitGameDialog()
            alert.confirmButton.tap()
            // then
            XCTAssert(homePage.exists)
        }
        XCTContext.runActivity(named: "読み上げモードを「初心者」に変更する") { _ in
            // when
            let selectModepage = homePage.gotoSelectModePage()
            // then
            XCTAssert(selectModepage.exists)
            // when
            selectModepage
                .selectMode(.beginner)
                .backToTopButton.tap()
            // then
            XCTAssert(homePage.exists)
            XCTAssert(homePage.reciteModeIs(.beginner))
        }
        // then
        XCTContext.runActivity(named: "読み上げる枚数が2枚に変わっている") { _ in
            // when
            let recitePage = homePage.gotoRecitePoemPage()
            recitePage.forwardButton.tap()
            // then
            XCTAssert(recitePage.isReciting(number: 1, side: .kami, total: 2))
        }
    }
}

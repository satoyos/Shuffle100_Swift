//
//  BeginnerModeUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/04/27.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class BeginnerModeUITest: XCTestCase {
    var app = XCUIApplication()
    lazy var homePage = HomePage(app: app)

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()

    }

    func test_startBeginnerMode() throws {
        // when
        let whatsNextPage = gotoWhatsNextPage()
        // then
        XCTAssert(whatsNextPage.exists)
    }
    
    func test_showTorifuda() {
        // given
        XCTContext.runActivity(named: "歌を1首(#4)だけ選んだ状態にする") { (activity) in
            // when
            let pickerPage = homePage.goToPoemPickerPage()
            // then
            XCTAssert(pickerPage.exists)
            // when
            pickerPage.cancelAllButton.tap()
            pickerPage.cellOf(number: 4).tap()
            pickerPage.backToTopButton.tap()
            // then
            XCTAssert(homePage.numberOfSelecttedPoems(is: 1))
        }
        // when
        let whatsNextPage = gotoWhatsNextPage(totalPoemsNum: 1)
        whatsNextPage.torifudaButton.tap()
        // then
        let fudaPage = TorifudaPage(app: app)
        XCTAssert(fudaPage.exists)
        XCTAssert(fudaPage.hasChar("ふ"))
        XCTAssert(fudaPage.hasChar("し"))
        XCTAssertFalse(fudaPage.hasChar("あ"))
        // when
        fudaPage.backToWhatsNextButton.tap()
        // then
        XCTAssert(whatsNextPage.exists)
    }
    
    func test_refrainShimo() {
        // given
        let recitePage = RecitePoemPage(app: app)
        // when
        let whatsNextPage = gotoWhatsNextPage()
        whatsNextPage.refrainButton.tap()
        // then
        XCTAssert(recitePage.exists, "読み上げ画面に戻る")
        XCTAssert(recitePage.appears(number: 1, side: .shimo))
        XCTContext.runActivity(named: "そのまま下の句の読み上げが終わると、再び「次はどうする？」画面が現れる") { _ in
            waitToAppear(for: whatsNextPage.pageTitle, timeout: 15)
        }
    }
    
    func test_goNext() {
        // when
        let whatsNextPage = gotoWhatsNextPage()
        whatsNextPage.nextPoemButton.tap()
        // then
        let recitePage = RecitePoemPage(app: app)
        XCTAssert(recitePage.appears(number: 2, side: .kami))
    }
    
    func test_exitGameFromWhatsNextScreen() {
        // when
        let whatsNextPage = gotoWhatsNextPage()
        whatsNextPage.exitButton.tap()
        // then
        let exitAlert = ExitGameAlert(app: app)
        XCTAssert(exitAlert.exists, "確認ダイアログが現れる")
        // when
        exitAlert.confirmButton.tap()
        // then
        XCTAssert(homePage.exists, "トップ画面に戻る")
    }
    
    func gotoWhatsNextPage(totalPoemsNum: Int = 100) -> WhatsNextpage {
        // when
        let selectModePage = homePage.gotoSelectModePage()
        // then
        XCTAssert(selectModePage.exists)
        // when
        selectModePage
            .selectMode(.beginner)
            .backToTopButton.tap()
        // then
        XCTAssert(homePage.reciteModeIs(.beginner))
        // when
        let recitePage = homePage.gotoRecitePoemPage()
        recitePage.tapForwardButton()
        // then
        XCTAssert(recitePage.appears(number: 1, side: .kami, total: totalPoemsNum))
        // when
        recitePage.tapForwardButton()
        // then
        XCTAssert(recitePage.appears(number: 1, side: .shimo, total: totalPoemsNum))
        // when
        recitePage.tapForwardButton()
        // then
        let whatsNextPage = WhatsNextpage(app: app)
        XCTAssert(whatsNextPage.exists)
        return whatsNextPage
    }
}

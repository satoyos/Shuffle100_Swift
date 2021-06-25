//
//  BeginnerModeUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/04/27.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class BeginnerModeUITest: XCTestCase, HomeScreenUITestUtils, RecitePoemScreenUITestUtils, PoemPickerScreenUITestUtils, ExitGameUITestUtils {
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
        gotoWhatsNextScreen(app)
        // when
        app.buttons["refrain"].tap()
        // then
        XCTContext.runActivity(named: "読み上げ画面に戻る") { activity in
            XCTAssert(app.staticTexts["1首め:下の句 (全100首)"].exists)
        }
        XCTContext.runActivity(named: "そのまま下の句の読み上げが終わると、再び「次はどうする？」画面が現れる") { activity in
            waitToAppear(for: app.staticTexts["次はどうする？"], timeout: 15)
        }
    }
    
    func test_goNext() {
        // given
        gotoWhatsNextScreen(app)
        // when
        app.buttons["goNext"].tap()
        // then
        XCTContext.runActivity(named: "そのまま2首めに移る") { activity in
            waitToAppear(for: app.staticTexts["2首め:上の句 (全100首)"], timeout: timeOutSec)
        }
    }
    
    func test_exitGameFromWhatsNextScreen() {
        // given
        gotoWhatsNextScreen(app)
        // when, then
        exitGameSuccessfully(app)
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
        XCTAssert(recitePage.recitePageAppears(number: 1, side: .kami, total: totalPoemsNum))
        // when
        recitePage.tapForwardButton()
        // then
        XCTAssert(recitePage.recitePageAppears(number: 1, side: .shimo, total: totalPoemsNum))
        // when
        recitePage.tapForwardButton()
        // then
        let whatsNextPage = WhatsNextpage(app: app)
        XCTAssert(whatsNextPage.exists)
        return whatsNextPage
    }
    
}

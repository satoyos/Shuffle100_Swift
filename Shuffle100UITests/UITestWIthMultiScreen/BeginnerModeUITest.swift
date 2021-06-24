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

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
            gotoPoemPickerScreen()
            let clearButton = waitToHittable(for: app.buttons["全て取消"])
            clearButton.tap()
            //   tap poems #4
            app.tables.cells["004"].tap()
            //   back to HomeScreen
            goBackToHomeScreen(app)
            // then
            XCTAssertTrue(app.cells.staticTexts["1首"].exists)
        }
        gotoWhatsNextScreen(app, poemsNumber: 1)
        // when
        app.buttons["torifuda"].tap()
        // then
        XCTAssert(app.images["fudaView"].exists)
        XCTAssert(app.staticTexts["ふ"].exists)
        XCTAssert(app.staticTexts["し"].exists)
        XCTAssertFalse(app.staticTexts["あ"].exists)
        XCTContext.runActivity(named: "「次はどうする？」画面に戻る") { _ in
            // when
            app.navigationBars.buttons["次はどうする？"].tap()
            // then
            XCTAssert(app.navigationBars["次はどうする？"].exists)
        }
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
    
    func gotoWhatsNextPage() -> WhatsNextpage {
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
        XCTAssert(recitePage.recitePageAppears(number: 1, side: .kami))
        // when
        recitePage.tapForwardButton()
        // then
        XCTAssert(recitePage.recitePageAppears(number: 1, side: .shimo))
        // when
        recitePage.tapForwardButton()
        // then
        let whatsNextPage = WhatsNextpage(app: app)
        XCTAssert(whatsNextPage.exists)
        return whatsNextPage
    }
    
}

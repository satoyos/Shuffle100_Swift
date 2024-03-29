//
//  GoThrough100PoemsUITest.swift
//  Shuffle100UITests
//
//  Created by 里 佳史 on 2019/11/27.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

class GoThrough100PoemsUITest: XCTestCase {
    var app = XCUIApplication()
    lazy var homePage = HomePage(app: app)
    
    override func setUp() {
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_goThroghWithSkipForward_inNormalMode() {
        
        let recitePage = homePage.gotoRecitePoemPage()
        let forwordButton = recitePage.forwardButton
        
        XCTAssert(recitePage.jokaTitle.exists, "まず序歌へ")

        for i in (1...100) {
            XCTContext.runActivity(named: "forwardボタンを押すと、\(i)首めの上の句へ") { (activiti) in
                forwordButton.tap()
                XCTAssert(recitePage.isReciting(number: i, side: .kami))
            }
            XCTContext.runActivity(named: "すぐに早送りボタンを押すと、下の句へ。") { (activiti) in
                forwordButton.tap()
                XCTAssert(recitePage.isReciting(number: i, side: .shimo))
            }
        }
        XCTContext.runActivity(named: "試合終了画面から、トップへ戻る)") { activity in
            // when
            forwordButton.tap()
            // then
            let allPoemRecitedPage = AllPoemRecitedPage(app: app)
            XCTAssert(allPoemRecitedPage.exists, "試合終了ページへ")
            // when
            allPoemRecitedPage.backToTopButton.tap()
            // then
            XCTAssert(homePage.exists, "トップページに戻ってくる")
        }
    }
    
    func test_goThoughInNonStopMode() {
        XCTContext.runActivity(named: "ノンストップモードを選択") { (activiti) in
            // given
            let selectModePage = homePage.gotoSelectModePage()
            // when
            selectModePage
                .selectMode(.nonstop)
                .backToTopButton.tap()
            // then
            XCTAssert(homePage.reciteModeIs(.nonstop))
        }

        let recitePage = homePage.gotoRecitePoemPage()

        for i in (1...100) {
            XCTContext.runActivity(named: "forwardボタンを押すと、\(i)首めの上の句へ") { (activiti) in
                // when
                recitePage.forwardButton.tap()
                // then
                XCTAssert(recitePage.isReciting(number: i, side: .kami))
            }
            XCTContext.runActivity(named: "上の句の読み上げ後、自動的に下の句へ") { (activiti) in
                // when
                recitePage.forwardButton.tap()
                // then
                XCTAssert(recitePage.isReciting(number: i, side: .shimo))
            }
        }
        XCTContext.runActivity(named: "試合終了画面から、トップへ戻る)") { activity in
            // when
            recitePage.forwardButton.tap()
            // then
            //            waitToAppear(for: allPoemRecitedPage.pageTitle, timeout: 12)
            let allPoemRecitedPage = AllPoemRecitedPage(app: app)
            XCTAssert(allPoemRecitedPage.exists)
            // when
            allPoemRecitedPage.backToTopButton.tap()
            // then
            XCTAssert(homePage.exists)
        }
    }
    
    func test_goThorough100InBeginnerMode() {
        XCTContext.runActivity(named: "初心者モードを選択") { (activity) in
            // given
            let selectModePage = homePage.gotoSelectModePage()
            // when
            selectModePage
                .selectMode(.beginner)
                .backToTopButton.tap()
            // then
            XCTAssert(homePage.reciteModeIs(.beginner))
        }
        // given
        let recitePage = homePage.gotoRecitePoemPage()
        let forwordButton = recitePage.forwardButton
        let whatsNextPage = WhatsNextpage(app: app)
        // when
        forwordButton.tap()
        
        for i in (1...100) {
            // then
            XCTAssert(recitePage.isReciting(number: i, side: .kami))
            // when
            forwordButton.tap()
            // then
            XCTAssert(recitePage.isReciting(number: i, side: .shimo))
            // when
            forwordButton.tap()
            // then
            XCTAssert(whatsNextPage.exists, "「次はどうする？」画面に到達")
            // when
            whatsNextPage.nextPoemButton.tap()
        }
        XCTContext.runActivity(named: "試合終了画面から、トップへ戻る)") { activity in
            // when
            let button = waitToHittable(for: app.buttons["トップに戻る"], timeout: 12)
            button.tap()
            // then
            XCTAssert(homePage.exists)
        }
    }
    
    func test_goThrough100inHokkaidoMode() {
        XCTContext.runActivity(named: "北海道モードを選択") { (activity) in
            // given
            let selectModePage = homePage.gotoSelectModePage()
            // when
            selectModePage
                .selectMode(.hokkaido)
                .backToTopButton.tap()
            // then
            XCTAssert(homePage.reciteModeIs(.hokkaido))
        }
        // given
        let whatsNextPage = WhatsNextpage(app: app)
        // when
        let recitePage = homePage.gotoRecitePoemPage()
        let forwordButton = recitePage.forwardButton
        forwordButton.tap()
        for i in (1...100) {
            // then
            XCTAssert(recitePage.isReciting(number: i, side: .shimo))
            // when
            forwordButton.tap()
            // then
            XCTAssert(whatsNextPage.exists, "「次はどうする？」画面に到達")
            // when
            whatsNextPage.nextPoemButton.tap()
            if i < 100 {
                // then
                XCTAssert(recitePage.isReciting(number: i, side: .shimo), "読み上げたばかりの下の句をもう一度読み上げる")
                // when
                forwordButton.tap()
            }
        }
        XCTContext.runActivity(named: "試合終了画面から、トップへ戻る)") { _ in
            // then
            let endPage = AllPoemRecitedPage(app: app)
            XCTAssert(endPage.exists)
            // when
            endPage.backToTopButton.tap()
            // then
            XCTAssert(homePage.exists)
        }
    }

    private func kamiRecitingScreenAppearsOf(number i: Int) {
        waitToAppear(for: app.staticTexts["\(i)首め:上の句 (全100首)"], timeout: timeOutSec)
    }
    
    private func shimoRecitingScreenAppearsOf(number i: Int) {
        waitToAppear(for: app.staticTexts["\(i)首め:下の句 (全100首)"], timeout: timeOutSec)
    }

}

//
//  SkipPoemUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/08/28.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import XCTest

class SkipPoemUITest: XCTestCase {
    let app = XCUIApplication()
    lazy var homePage = HomePage(app: app)
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    func test_skipButtonOn1stHalfOf1stPoemShouldWork() {
        // when
        let recitePage = homePage.gotoRecitePoemPage()
        recitePage.tapForwardButton()
        // then
        XCTAssert(recitePage.isReciting(number: 1, side: .kami))
        // when
        recitePage.playButton.tap()
        // then
        XCTAssert(recitePage.isWaitinfForPlay, "停止状態になり、再生ボタンは再生指示待ち表示になる")
        // when
        recitePage.tapForwardButton()
        // then
        XCTAssert(recitePage.isReciting(number: 1, side: .shimo))
    }
    
    func test_alsoInBeginnerMode_skipButtonOn1stHalfOf1stPoemShouldWork() {
        // when
        let modePage = homePage.gotoSelectModePage()
        modePage
            .selectMode(.beginner)
            .backToTopButton.tap()
        // then
        XCTAssert(homePage.reciteModeIs(.beginner))
        // when
        let recitePage = homePage.gotoRecitePoemPage()
        recitePage
            .tapForwardButton()
            .andWait(sec: 1)
            .playButton.tap()
        // then
        XCTAssert(recitePage.isWaitinfForPlay)
        // when
        recitePage.tapForwardButton()
        // then
        XCTAssert(recitePage.isReciting(number: 1, side: .shimo))
    }
    
    func test_alsoInNonStopMode_skipButtonOn1stHalfOf1stPoemShouldWork() {
        // when
        let modePage = homePage.gotoSelectModePage()
        modePage
            .selectMode(.nonstop)
            .backToTopButton.tap()
        // then
        XCTAssert(homePage.reciteModeIs(.nonstop))
        // when
        let recitePage = homePage.gotoRecitePoemPage()
        recitePage
            .tapForwardButton()
            .andWait(sec: 1)
            .playButton.tap()
        // then
        XCTAssert(recitePage.isWaitinfForPlay)
        // when
        recitePage.tapForwardButton()
        // then
        XCTAssert(recitePage.isReciting(number: 1, side: .shimo))
    }
    
    func test_skipKamiWhilePlaying_shouldGoToShimoSoon() {
        // when
        let recitePage = homePage.gotoRecitePoemPage()
        // then
        XCTAssert(recitePage.isRecitingJoka)
        // when
        recitePage.tapForwardButton()
        // then
        XCTAssert(recitePage.isReciting(number: 1, side: .kami))
        // when
        recitePage.tapForwardButton()
        // then
        XCTAssert(recitePage.isReciting(number: 1, side: .shimo))
    }
}

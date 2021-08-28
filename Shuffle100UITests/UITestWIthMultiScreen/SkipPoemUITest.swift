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

    func test_skipButtonOn1stHalfOf1stPoem_ShouldStartReciting2ndHalf() {
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

}

//
//  RewindButtonUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/02/09.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class RewindButtonUITest: XCTestCase {
    internal let app = XCUIApplication()
    internal lazy var homePage = HomePage(app: app)

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    func test_rewindInJokaGoBackToTop() {
        // when
        let recitePage = homePage.gotoRecitePoemPage()
        recitePage
            .tapRewindButton()
            .tapRewindButton()
        // then
        XCTAssert(homePage.exists, "トップ画面に戻る")
    }

    func test_rewindInNunberedPoem_atKami() {
        let recitePage = homePage.gotoRecitePoemPage()
        XCTContext.runActivity(named: "2首目の上の句まで進む") { _ in
            // when
            recitePage
                .tapForwardButton()
                .tapForwardButton()
                .tapForwardButton()
                .tapForwardButton()
            // then
            XCTAssert(recitePage.isReciting(number: 2, side: .kami))
        }
        XCTContext.runActivity(named: "2首目の上の句を読み始めた状態でrewindボタンを2回押すと、1首めの下の句に戻る") { _ in
            // when
            recitePage
                .tapRewindButton()
                .tapRewindButton()
            // then
            XCTAssert(recitePage.isReciting(number: 1, side: .shimo))
        }
    }
    
    func test_rewindInNumberedPoem_atShimo() {
        let recitePage = homePage.gotoRecitePoemPage()
        XCTContext.runActivity(named: "1首目の下の句まで進む") { _ in
            // when
            recitePage
                .tapForwardButton()
                .tapForwardButton()
                .tapForwardButton()
            // then
            XCTAssert(recitePage.isReciting(number: 1, side: .shimo))
        }
        XCTContext.runActivity(named: "下の句を読み始めた状態でrewindボタンを2回押すと、上の句に戻る") { _ in
            // when
            recitePage
                .tapRewindButton()
                .tapRewindButton()
            // then
            XCTAssert(recitePage.isReciting(number: 1, side: .kami))
        }
    }
    
}

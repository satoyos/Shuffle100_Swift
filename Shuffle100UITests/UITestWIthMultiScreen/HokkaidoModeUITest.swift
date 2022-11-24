//
//  HokkaidoModeUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2022/11/21.
//  Copyright © 2022 里 佳史. All rights reserved.
//

import XCTest

#if HOKKAI
final class HokkaidoModeUITest: XCTestCase {
    let app = XCUIApplication()
    lazy var homePage = HomePage(app: app)
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }

   
    func test_selectHokkaidoMode() throws {
        setHokkaidoMode()
    }
    
    func test_startGameInHokkaidoMode() {
        // given
        setHokkaidoMode()
        // when
        let recitePage = homePage.gotoRecitePoemPage()
        // then
        XCTAssert(recitePage.isRecitingJoka)
        // when
        recitePage.tapForwardButton()
        // then
        XCTAssert(recitePage.isReciting(number: 1, side: .shimo))
        // when
        recitePage.tapForwardButton()
        // then
        let whatsNextPage = WhatsNextpage(app: app)
        XCTAssert(whatsNextPage.exists)
    }
    
    private func setHokkaidoMode() {
        // when
        let selectModePage = homePage.gotoSelectModePage()
        // then
        XCTAssert(selectModePage.exists)
        // when
        selectModePage
            .selectMode(.hokkaido)
            .backToTopButton.tap()
        // then
        XCTAssert(homePage.reciteModeIs(.hokkaido))
    }

}
#endif

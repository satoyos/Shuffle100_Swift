//
//  HokkaidoModeUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2022/11/21.
//  Copyright © 2022 里 佳史. All rights reserved.
//

import XCTest

#if HOKKAI
final class HokkaidoModeUITest: XCTestCase, OnWhatsNextScreenTest {
    let app = XCUIApplication()
    lazy var homePage = HomePage(app: app)
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    func test_startGameInHokkaidoMode() {
        let whatsNextPage = homePage.skipToWhatsNextPage(mode: .hokkaido)
        XCTAssert(whatsNextPage.exists)
    }
    
    func test_showTorifuda() {
        showTorifudaTest(mode: .hokkaido)
    }
    
    func test_refrainShimo() {
        refrainShimoTest(mode: .hokkaido)
    }
    
    func test_goNext() {
        goNextTest()
    }
    
    func goNextTest() {
        // when
        let whatsNextPage = homePage.skipToWhatsNextPage(mode: .hokkaido)
        whatsNextPage.nextPoemButton.tap()
        // then
        let recitePage = RecitePoemPage(app: app)
        XCTAssert(recitePage.isReciting(number: 1, side: .shimo), "読み上げたばかりに下の句をもう一度読み上げる")
        // when
        recitePage.tapForwardButton()
        // then
        XCTAssert(recitePage.isReciting(number: 2, side: .shimo), "今度は「次はどうする？」画面に遷移せず、次の詩に進む")
    }
}
#endif

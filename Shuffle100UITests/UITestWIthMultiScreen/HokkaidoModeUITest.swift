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
}
#endif

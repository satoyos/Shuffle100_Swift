//
//  TimeSettingScreenUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2023/03/19.
//  Copyright © 2023 里 佳史. All rights reserved.
//

import XCTest

final class TimeSettingScreenUITest: XCTestCase {
    let app = XCUIApplication()
    lazy var homePage = HomePage(app: app)

    override func setUpWithError() throws {
        super.setUp()
            continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    func test_secCharLabelExists_inIntervalSettingScreen() {
        // given, when
        let reciteSettingPage = homePage.gotoReciteSettingPage()
        // then
        XCTAssert(reciteSettingPage.exists)
        // when
        let intervalSettingPage =  reciteSettingPage.gotoIntervalSettingPage()
        // when
        XCTAssert(intervalSettingPage.exists)
        XCTAssert(intervalSettingPage.secCharLabel.exists)
    }


}

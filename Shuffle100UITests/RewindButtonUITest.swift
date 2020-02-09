//
//  RewindButtonUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/02/09.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class RewindButtonUITest: XCTestCase, RecitePoemScreenUITestUtils, HomeScreenUITestUtils {
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchEnvironment = ["IS_TESTING" : "1"]
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_rewindInJokaGoBackToTop() {
        // given
        gotoRecitePoemScreen(app)
        // when
        let rewindButton = app.buttons["rewind"]
        sleep(1)
        rewindButton.tap()
        sleep(1)
        rewindButton.tap()
        // then
        XCTAssertTrue(app.navigationBars["トップ"].exists)
    }

}

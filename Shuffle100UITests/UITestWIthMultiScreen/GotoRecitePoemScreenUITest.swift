//
//  GotoRecitePoemScreenUITest.swift
//  Shuffle100UITests
//
//  Created by 里 佳史 on 2019/07/14.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

class GotoRecitePoemScreenUITest: XCTestCase, HomeScreenUITestUtils, ExitGameUITestUtils {
    var app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    func test_RecitePoemScreenAppearWhenGameStartCellTapped() {
        gotoRecitePoemScreen()
    }
    
    func test_backToHomeScreenUsingExitButton() {
        // given
        gotoRecitePoemScreen()
        // when, then
        exitGameSuccessfully(app)
    }
}

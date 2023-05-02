//
//  DigitsPickerScreenUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2023/05/01.
//  Copyright © 2023 里 佳史. All rights reserved.
//

import XCTest

final class DigitsPickerScreenUITest: XCTestCase {
    var app = XCUIApplication()
    lazy var homePage = HomePage(app: app)

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    func test_openDigitsPicker() throws {
        // when
        let pickerPage = homePage.goToPoemPickerPage()
        // then
        XCTAssert(pickerPage.exists, "「歌を選ぶ」画面に到達")
        // when
        let _ = pickerPage.gotoDigitsPickerPage()
    }
}

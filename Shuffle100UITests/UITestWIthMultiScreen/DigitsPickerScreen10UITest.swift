//
//  DigitsPickerScreen10UITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2023/05/14.
//  Copyright © 2023 里 佳史. All rights reserved.
//

import XCTest

final class DigitsPickerScreen10UITest: XCTestCase {
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
        XCTAssert(pickerPage.exists)
        // when
        let digitsPage = pickerPage.gotoDigitsPickerPage10()
        // then
        XCTAssert(digitsPage.exists)
    }

    func test_tapFullSelectedCell() {
        // when
        let pickerPage = homePage.goToPoemPickerPage()
        // then
        XCTAssert(pickerPage.exists)
        // when
        let digitsPage = pickerPage.gotoDigitsPickerPage10()
        // then
        XCTAssert(digitsPage.badge(of: 100).exists)
        // when
        digitsPage.tapCell(number: 2)
        // then
        XCTAssert(digitsPage.badge(of: 90).exists)
        // when
        digitsPage.backToPickerButton.tap()
        // then
        XCTAssert(pickerPage.badge(of: 90).exists)
        // when
        pickerPage.backToTopButton.tap()
        // then
        XCTAssert(homePage.numberOfSelecttedPoems(is: 90))
    }
}

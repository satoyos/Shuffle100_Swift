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

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_OpenDigitsPicker() throws {
        // when
        let pickerPage = homePage.goToPoemPickerPage()
        // then
        XCTAssert(pickerPage.exists)
        // when
        let sheet = pickerPage.showSelectByGroupActionSheet()
        // then
        XCTAssert(sheet.selectByDigits10Button.exists)
    }

}

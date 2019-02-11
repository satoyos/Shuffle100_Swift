//
//  SelectModeScreenUITest.swift
//  Shuffle100UITests
//
//  Created by 里 佳史 on 2019/02/11.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

class SelectModeScreenUITest: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_tappingReciteModeCellShowsSelectModeScreen() {
        // given
        let reciteModeCell = app.tables.cells.staticTexts["読み上げモード"]
        
        // when
        reciteModeCell.tap()
        
        // then
        XCTAssert(app.navigationBars["読み上げモードを選ぶ"].exists)
        XCTAssertNotNil(app.pickerWheels.element.staticTexts["通常 (競技かるた)"])        
    }

}

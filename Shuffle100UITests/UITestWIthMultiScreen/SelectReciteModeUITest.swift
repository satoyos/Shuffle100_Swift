//
//  SelectReciteModeUITest.swift
//  Shuffle100UITests
//
//  Created by 里 佳史 on 2019/03/03.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

class SelectReciteModeUITest: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_HomeScreenReflectsSelectedMode() {
        // given
        let reciteModeCell = app.tables.cells.staticTexts["読み上げモード"]
        
        // when
        reciteModeCell.tap()
        app.pickerWheels.element.adjust(toPickerWheelValue: "初心者 (チラし取り)")
        app.buttons["トップ"].tap()
        
        // then
        XCTAssertTrue(app.cells.staticTexts["初心者"].exists)
    }

}

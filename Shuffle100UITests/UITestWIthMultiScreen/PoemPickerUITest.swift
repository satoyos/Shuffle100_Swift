//
//  PoemPickerUITest.swift
//  Shuffle100UITests
//
//  Created by 里 佳史 on 2019/05/06.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

class PoemPickerUITest: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_HomeScreenReflectsSelectioninPoemPicker() {
        // given
        let tablesQuery = app.tables
        XCTAssertTrue(app.cells.staticTexts["100首"].exists)
        // when
        //   goes to PocmPickerScreen
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["取り札を用意する歌"]/*[[".cells[\"poemsCell\"].staticTexts[\"取り札を用意する歌\"]",".staticTexts[\"取り札を用意する歌\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        //   tap poems #1,2, 4
        tablesQuery.cells["001"].tap()
        tablesQuery.cells["002"].tap()
        tablesQuery.cells["004"].tap()
        //   back to HomeScreen
        app.navigationBars["歌を選ぶ"].buttons["トップ"].tap()
        // then
        XCTAssertTrue(app.cells.staticTexts["97首"].exists)
    }
}


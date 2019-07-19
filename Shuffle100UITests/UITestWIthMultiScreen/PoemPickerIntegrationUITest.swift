//
//  PoemPickerUITest.swift
//  Shuffle100UITests
//
//  Created by 里 佳史 on 2019/05/06.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

class PoemPickerIntegrationUITest: XCTestCase {
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
    
    
    func test_HomeScreenReflectsSelectioninPoemPicker() {
        let tablesQuery = app.tables

        XCTContext.runActivity(named: "デフォルトのトップ画面に「100首」と書かれたセルが存在する") { (activity) in
            XCTAssertTrue(app.cells.staticTexts["100首"].exists)
        }
        XCTContext.runActivity(named: "「取り札を用意する歌」セルをタップすると、歌選択画面に遷移する") { (activity) in
            tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["取り札を用意する歌"]/*[[".cells[\"poemsCell\"].staticTexts[\"取り札を用意する歌\"]",".staticTexts[\"取り札を用意する歌\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
            XCTAssert(app.navigationBars["歌を選ぶ"].exists)
        }
        XCTContext.runActivity(named: "歌を3つタップして選択状態を解除し、トップ画面に戻ると、歌の数が97首になっている") { (activity) in
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
}


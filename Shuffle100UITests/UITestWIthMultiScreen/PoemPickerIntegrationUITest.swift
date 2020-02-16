//
//  PoemPickerUITest.swift
//  Shuffle100UITests
//
//  Created by 里 佳史 on 2019/05/06.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

class PoemPickerIntegrationUITest: XCTestCase, HomeScreenUITestUtils, SetEnvUITestUtils {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        setEnvTesting(app)
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func test_HomeScreenReflectsSelectioninPoemPicker() {
        
        XCTContext.runActivity(named: "デフォルトのトップ画面に「100首」と書かれたセルが存在する") { (activity) in
            XCTAssertTrue(app.cells.staticTexts["100首"].exists)
        }
        gotoPoemPickerScreen(app)
        XCTContext.runActivity(named: "プレースホルダ付きの検索窓がある") { (activity) in
            XCTAssert(app.searchFields["歌を検索"].exists)
        }
        XCTContext.runActivity(named: "歌を3つタップして選択状態を解除し、トップ画面に戻ると、歌の数が97首になっている") { (activity) in
            //   tap poems #1,2, 4
            app.tables.cells["001"].tap()
            app.tables.cells["002"].tap()
            app.tables.cells["004"].tap()
            //   back to HomeScreen
            app.navigationBars["歌を選ぶ"].buttons["トップ"].tap()
            // then
            XCTAssertTrue(app.cells.staticTexts["97首"].exists)
        }
    }
    
    func test_searchPoem() {
        // given
        gotoPoemPickerScreen(app)
        XCTContext.runActivity(named: "検索窓に「あき」を入力すると、検索用データがそれにヒットする歌のみ表示される"){
            (activity) in
            // when
            let searchField = app.searchFields.element
            searchField.tap()
            searchField.typeText("あき")
            // then
            XCTAssert(app.tables.cells["001"].exists)
            XCTAssertFalse(app.tables.cells["002"].exists)
            XCTAssert(app.tables.cells["005"].exists)
        }
        XCTContext.runActivity(named: "検索結果としてフィルタリングされた歌をタップしたら、選択状態を変えることができる") { (acitvity) in
            // when
            app.tables.cells["001"].tap()
            app.tables.cells["005"].tap()
            app.buttons["Cancel"].tap()
            //   back to HomeScreen
            app.navigationBars["歌を選ぶ"].buttons["トップ"].tap()
            // then
            XCTAssertTrue(app.cells.staticTexts["98首"].exists)
        }
    }
}


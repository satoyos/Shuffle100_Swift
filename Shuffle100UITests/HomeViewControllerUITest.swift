//
//  HomeViewControllerUITest.swift
//  Shuffle100UITests
//
//  Created by 里 佳史 on 2018/09/16.
//  Copyright © 2018年 里 佳史. All rights reserved.
//

import XCTest

class HomeViewControllerUITest: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchEnvironment = ["IS_TESTING" : "1"]
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_defaultCellsAndButtonsExistOnLoad() {
        correctLabelAndCellsExist()
        navBarButtonsExists()
    }
    
    private func correctLabelAndCellsExist() {
        XCTAssert(app.navigationBars["トップ"].exists)
        XCTAssert(cellExistsWithText("取り札を用意する歌"))
        XCTAssert(cellExistsWithText("読み上げモード"))
        XCTAssert(cellExistsWithText("空札を加える"))
        XCTAssert(cellExistsWithText("読手"))
    }
    
    private func navBarButtonsExists() {
        XCTAssert(app.navigationBars.buttons["GearButton"].exists)
        XCTAssert(app.navigationBars.buttons["HelpButton"].exists)
    }
    
    private func cellExistsWithText(_ text: String) -> Bool {
        return app.tables.cells.staticTexts[text].exists
    }
}

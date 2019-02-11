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
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_correctLabelAndCellsAppearOnLoad() {
        XCTAssert(app.navigationBars["トップ"].exists)
        XCTAssert(cellExistsWithText("取り札を用意する歌"))
        XCTAssert(cellExistsWithText("読み上げモード"))
        XCTAssert(cellExistsWithText("空札を加える"))
        XCTAssert(cellExistsWithText("読手"))
    }
    
    func test_navBarButtonsExists() {
        XCTAssert(app.navigationBars.buttons["GearButton"].exists)
        XCTAssert(app.navigationBars.buttons["HelpButton"].exists)
    }
    
    
    fileprivate func cellExistsWithText(_ text: String) -> Bool {
        return app.tables.cells.staticTexts[text].exists
    }
}

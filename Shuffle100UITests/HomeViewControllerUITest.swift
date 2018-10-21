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
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_onLoad() {
        XCTAssert(app.navigationBars["トップ"].exists)
        XCTAssert(cellExistsWithText("取り札を用意する歌"))
        XCTAssert(cellExistsWithText("読み上げモード"))
        XCTAssert(cellExistsWithText("初心者モード"))
        XCTAssert(cellExistsWithText("読手"))
    }
    
    fileprivate func cellExistsWithText(_ text: String) -> Bool {
        return app.tables.cells.staticTexts[text].exists
    }
}

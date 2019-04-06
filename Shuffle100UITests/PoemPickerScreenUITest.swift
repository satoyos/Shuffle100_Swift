//
//  PoemPickerScreenUITest.swift
//  Shuffle100UITests
//
//  Created by 里 佳史 on 2019/03/10.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

class PoemPickerScreenUITest: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_openPoemPickerScreen() {
        // when
        app.tables.cells.staticTexts["取り札を用意する歌"].tap()
        
        // then
        XCTAssertTrue(app.staticTexts["百首読み上げ"].exists)
        XCTAssertTrue(app.staticTexts["2. 春過ぎて 夏来にけらし 白妙の 衣干すてふ 天の香具山"].exists)
    }
 }

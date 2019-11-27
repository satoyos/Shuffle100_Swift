//
//  GoThrough100PoemsUITest.swift
//  Shuffle100UITests
//
//  Created by 里 佳史 on 2019/11/27.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

class GoThrough100PoemsUITest: XCTestCase {
    var app = XCUIApplication()
    
    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_goThroghWithSkipForward() {
        XCTContext.runActivity(named: "まず序歌へ") { (activiti) in
            gotoRecitePoemScreenFromHome()
        }
//        sleep(1)
        XCTContext.runActivity(named: "forwardボタンを押すと、1首めの上の句へ") { (activiti) in
            app.buttons["forward"].tap()
            sleep(1)
            XCTAssert(app.staticTexts["1首め:上の句 (全100首)"].exists)
        }
    }

    private func gotoRecitePoemScreenFromHome() {
        // when
        app.tables.cells["GameStartCell"].tap()
        // then
        XCTAssert(app.staticTexts["序歌"].exists)
    }
}

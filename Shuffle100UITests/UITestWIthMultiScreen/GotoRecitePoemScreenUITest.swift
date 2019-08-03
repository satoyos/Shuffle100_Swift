//
//  GotoRecitePoemScreenUITest.swift
//  Shuffle100UITests
//
//  Created by 里 佳史 on 2019/07/14.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

class GotoRecitePoemScreenUITest: XCTestCase {
    var app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_RecitePoemScreenAppearWhenGameStartCellTapped() {
        gotoRecitePoemScreenFromHome()
    }
    
    func test_backToHomeScreenUsingExitButton() {
        // given
        gotoRecitePoemScreenFromHome()
        
        XCTContext.runActivity(named: "Exitボタンを押すと、確認のダイアログが現れる") { (activiti) in
            // when
            app.buttons["exit"].tap()
            // then
            XCTAssert(app.alerts.staticTexts["試合を終了しますか？"].exists)
        }
        
        XCTContext.runActivity(named: "確認ダイアログで「終了する」を押すと、トップ画面に戻る") {
            (activity) in
            // when
            app.alerts.buttons["終了する"].tap()
            // then
            XCTAssert(app.navigationBars["トップ"].exists)
        }
    }
    
    private func gotoRecitePoemScreenFromHome() {
        // when
        app.tables.cells["GameStartCell"].tap()
        // then
        XCTAssert(app.staticTexts["序歌"].exists)
    }
}

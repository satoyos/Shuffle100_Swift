//
//  NgramPickerUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/05/06.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class NgramPickerUITest: XCTestCase, HomeScreenUITestUtils {
    var app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_openNgramPicker() throws {
        gotoPoemPickerScreen(app)
        gotoNgramPickerScreenFromPickerScreen(app)
    }

    func test_tapFullSelectedCell() {
        // given
        gotoPoemPickerScreen(app)
        gotoNgramPickerScreenFromPickerScreen(app)
        // when
        app.cells["just_one"].tap()
        // then
        XCTContext.runActivity(named: "トップ画面に戻ると、一字決まり分の選択が外れた「93首」が表示されている") { activity in
            goBackToTopScreen(app)
            XCTAssert(app.staticTexts["93首"].exists)
        }
    }
    
    func test_tapEmptySelectedCell() {
        XCTContext.runActivity(named: "全ての選択を外して、「1字目で選ぶ」画面へ移動する") { activity in
            gotoPoemPickerScreen(app)
            let button = waitToHittable(for: app.buttons["全て取消"], timeout: 3)
            button.tap()
            gotoNgramPickerScreenFromPickerScreen(app)
        }
        // when
        app.cells["shi"].tap()
        // then
        goBackToTopScreen(app)
        XCTAssert(app.staticTexts["2首"].exists)
        
    }
    
    func test_selectSeveralCells() {
        XCTContext.runActivity(named: "全ての選択を外して、「1字目で選ぶ」画面へ移動する") { activity in
            gotoPoemPickerScreen(app)
            let button = waitToHittable(for: app.buttons["全て取消"], timeout: 3)
            button.tap()
            gotoNgramPickerScreenFromPickerScreen(app)
        }
        // when
        app.cells["u"].tap()
        app.cells["tsu"].tap()
        app.cells["shi"].tap()
        app.cells["mo"].tap()
        app.cells["yu"].tap()
        // then
        goBackToTopScreen(app)
        XCTAssert(app.staticTexts["10首"].exists)
    }
    
    private func gotoNgramPickerScreenFromPickerScreen(_ app: XCUIApplication) {
        // given
        let button = waitToHittable(for: app.buttons["まとめて選ぶ"], timeout: 3)
        // when
        button.tap()
        // then
        XCTAssert(app.staticTexts["どうやって選びますか？"].exists)
        // when
        app.buttons["1字目で選ぶ"].tap()
        // then
        waitToAppear(for: app.navigationBars["1字目で選ぶ"], timeout: 5)
    }
    
    private func goBackToTopScreen(_ app: XCUIApplication) {
        app.buttons["歌を選ぶ"].tap()
        app.buttons["トップ"].tap()
    }
}

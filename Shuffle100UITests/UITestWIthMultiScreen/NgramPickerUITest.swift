//
//  NgramPickerUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/05/06.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class NgramPickerUITest: XCTestCase, HomeScreenUITestUtils, NgramPickerScreenTestUtils {
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
        // when
        select93Excluding1jiKimari(app)
        // then
        XCTContext.runActivity(named: "トップ画面に戻ると、一字決まり分の選択が外れた「93首」が表示されている") { activity in
            // when
            goBackToHomeScreen(app)
            // then
            XCTAssert(app.staticTexts["93首"].exists)
        }
    }
    
    func test_tapEmptySelectedCell() {
        XCTContext.runActivity(named: "全ての選択を外して、「1字目で選ぶ」画面へ移動する") { activity in
            gotoPoemPickerScreen(app)
            let button = waitToHittable(for: app.buttons["全て取消"], timeout: timeOutSec)
            button.tap()
            gotoNgramPickerScreenFromPickerScreen(app)
        }
        // when
        app.cells["shi"].tap()
        goBackToPoemPickerScreen(app)
        goBackToHomeScreen(app)
        // then
        XCTAssert(app.staticTexts["2首"].exists)
        
    }
    
    func test_selectSeveralCells() {
        // given
        gotoPoemPickerScreen(app)
        // whwn
        selectAll2maiFudaFromPoemPickerScreen(app)
        // then
        goBackToHomeScreen(app)
        XCTAssert(app.staticTexts["10首"].exists)
    }
    
    internal func gotoNgramPickerScreenFromPickerScreen(_ app: XCUIApplication) {
        // given
        let button = waitToHittable(for: app.buttons["まとめて選ぶ"], timeout: timeOutSec)
        // when
        button.tap()
        // then
        XCTAssert(app.staticTexts["どうやって選びますか？"].exists)
        // when
        app.buttons["1字目で選ぶ"].tap()
        // then
        waitToAppear(for: app.navigationBars["1字目で選ぶ"], timeout: timeOutSec)
    }
}

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
        gotoNgramPickerScreen(app)
    }

    func test_tapCellaffectsSelectedNum() {
        // given
        gotoNgramPickerScreen(app)
        // when
        app.cells["just_one"].tap()
        // then
        XCTContext.runActivity(named: "トップ画面に戻ると、一字決まり分の選択が外れた「93首」が表示されている") { activity in
            goBackToTopScreen(app)
            XCTAssert(app.staticTexts["93首"].exists)
            
        }
    }
    
    private func gotoNgramPickerScreen(_ app: XCUIApplication) {
        // given
        gotoPoemPickerScreen(app)
        // when
        let button = waitToHittable(for: app.buttons["まとめて選ぶ"], timeout: 3)
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

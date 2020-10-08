//
//  FiveColorsPickerUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/09/09.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class FiveColorsPickerUITest: XCTestCase, HomeScreenUITestUtils, NgramPickerScreenTestUtils {

    private var app = XCUIApplication()
    private let timeOutSec = 8.0
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_selectByGroupActionsIncludsActionFor5Colors() throws {
        // given
        gotoPoemPickerScreen(app)
        // when
        let button = waitToHittable(for: app.toolbars.buttons["まとめて選ぶ"], timeout: timeOutSec)
        button.tap()
        // then
        XCTAssert(app.buttons["1字目で選ぶ"].exists)
        
        // バージョン6.2から五色百人一首機能を追加
        XCTAssert(app.sheets.buttons["五色百人一首の色で選ぶ"].exists)
    }
    
    func test_buttonsOn5ColorsScreenWork() {
        // given
        gotoPoemPickerScreen(app)
        gotoFiveColorsScreen(app)
    }
    
    func test_whenColorButtonTapped_actionSheetAppears() {
        // given
        gotoPoemPickerScreen(app)
        let toolBarButton = waitToHittable(for: app.buttons["全て取消"], timeout: timeOutSec)
        toolBarButton.tap()
        gotoFiveColorsScreen(app)
        // when
        let blueButton = waitToHittable(for: app.buttons["青"], timeout: timeOutSec)
        blueButton.tap()
        // then
        XCTAssert(app.sheets.buttons["この20首だけを選ぶ"].exists)
        XCTAssert(app.sheets.buttons["今選んでいる札に加える"].exists)
    }
    
    func test_selectJust20ofColor() {
        // given
        XCTContext.runActivity(named: "デフォルトでは100首が選ばれている") { _ in
            XCTAssert(app.cells.staticTexts["100首"].exists)
        }
        gotoPoemPickerScreen(app)
        gotoFiveColorsScreen(app)
        // when
        let greenButton = waitToHittable(for: app.buttons["緑"], timeout: timeOutSec)
        greenButton.tap()
        let just20Button = waitToHittable(for: app.sheets.buttons["この20首だけを選ぶ"], timeout: timeOutSec)
        just20Button.tap()
        // then
        goBackToPoemPickerScreen(app)
        goBackToHomeScreen(app)
        XCTAssert(app.cells.staticTexts["20首"].exists)
        
    }
    
    func test_add20ofColor() {
        // given
        XCTContext.runActivity(named: "1字決まりの札を選んでおく") { _ in
            gotoPoemPickerScreen(app)
            select1jiKimari(app)
        }
        // when
        XCTContext.runActivity(named: "そこに、五色百人一首の黄色セットを追加する") { _ in
            gotoFiveColorsScreen(app)
            let yellowButton = waitToHittable(for: app.buttons["黄"], timeout: timeOutSec)
            yellowButton.tap()
            let add20Button = waitToHittable(for: app.sheets.buttons["今選んでいる札に加える"], timeout: timeOutSec)
            add20Button.tap()
        }
        // then
        XCTContext.runActivity(named: "黄色の20枚には一字決まりの歌が3首含まれているので、足すと27枚ではなく24枚になる") { _ in
            goBackToPoemPickerScreen(app)
            goBackToHomeScreen(app)
            XCTAssert(app.cells.staticTexts["24首"].exists)

        }
    }
    
    func gotoFiveColorsScreen(_ app: XCUIApplication) {
        // when
        let toolBarButton = waitToHittable(for: app.toolbars.buttons["まとめて選ぶ"], timeout: timeOutSec)
        toolBarButton.tap()
        let menuButton = waitToHittable(for: app.sheets.buttons["五色百人一首の色で選ぶ"], timeout: timeOutSec)
        menuButton.tap()
        // then
        waitToAppear(for: app.navigationBars["五色百人一首"], timeout: timeOutSec)
    }
}

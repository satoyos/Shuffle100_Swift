//
//  FiveColorsPickerUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/09/09.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class FiveColorsPickerUITest: XCTestCase, HomeScreenUITestUtils, NgramPickerScreenTestUtils {

    internal var app = XCUIApplication()
    internal lazy var homePage = HomePage(app: app)
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
        // when
        let pickerPage = homePage.goToPoemPickerPage()
        let sheet = pickerPage.showSelectByGroupActionSheet()
        // then
        XCTAssert(sheet.exists)
        XCTAssert(sheet.selectByColorButton.exists)
    }
    
    func test_buttonsOn5ColorsScreenWork() {
        // when
        let pickerPage = homePage.goToPoemPickerPage()
        let fiveColorsPage = pickerPage.gotoFiveColorsPage()
        // then
        XCTAssert(fiveColorsPage.exists, "五色百人一首の画面に到達")
    }
    
    func test_whenColorButtonTapped_actionSheetAppears() {
        // when
        let pickerPage = homePage.goToPoemPickerPage()
        pickerPage.cancelAllButton.tap()
        let colorsPage = pickerPage.gotoFiveColorsPage()
        // then
        XCTAssert(colorsPage.exists)
        // when
        let sheet = colorsPage.tapColorButton(of: .blue)
        // then
        XCTAssert(sheet.exists)
    }
    
    func test_selectJust20ofColor() {
        // given
        XCTContext.runActivity(named: "デフォルトでは100首が選ばれている") { _ in
            XCTAssert(app.cells.staticTexts["100首"].exists)
        }
        gotoPoemPickerScreen()
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
            gotoPoemPickerScreen()
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
    
    func test_select2colors() {
        gotoPoemPickerScreen()
        gotoFiveColorsScreen(app)
        // when
        let greenButton = waitToHittable(for: app.buttons["緑"], timeout: timeOutSec)
        greenButton.tap()
        let just20Button = waitToHittable(for: app.sheets.buttons["この20首だけを選ぶ"], timeout: timeOutSec)
        just20Button.tap()
        let pinkButton = waitToHittable(for: app.buttons["桃(ピンク)"], timeout: timeOutSec)
        pinkButton.tap()
        let add20Button = waitToHittable(for: app.sheets.buttons["今選んでいる札に加える"], timeout: timeOutSec)
        add20Button.tap()
        // then
        goBackToPoemPickerScreen(app)
        goBackToHomeScreen(app)
        XCTAssert(app.cells.staticTexts["40首"].exists)
    }
    
    internal func gotoFiveColorsScreen(_ app: XCUIApplication) {
        // when
        let toolBarButton = waitToHittable(for: app.toolbars.buttons["まとめて選ぶ"], timeout: timeOutSec)
        toolBarButton.tap()
        let menuButton = waitToHittable(for: app.sheets.buttons["五色百人一首の色で選ぶ"], timeout: timeOutSec)
        menuButton.tap()
        // then
        waitToAppear(for: app.navigationBars["五色百人一首"], timeout: timeOutSec)
    }
}

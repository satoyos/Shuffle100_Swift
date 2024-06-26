//
//  FiveColorsPickerUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/09/09.
//  Copyright © 2020 里 佳史. All rights reserved.
//

@testable import Shuffle100
import XCTest

class FiveColorsPickerUITest: XCTestCase {

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
        XCTAssert(homePage.numberOfSelecttedPoems(is: 100), "デフォルトでは100首が選ばれている")
        // when
        let pickerPage = homePage.goToPoemPickerPage()
        let colorPage = pickerPage.gotoFiveColorsPage()
        // then
        XCTAssert(colorPage.exists)
        // when
        let sheet = colorPage.tapColorButton(of: .green)
        // then
        XCTAssert(sheet.exists)
        // when
        sheet.selectOnlyThese20Button.tap()
        // then
        XCTAssert(colorPage.badge(of: 20).exists)
        // when
        colorPage.backButton.tap()
        pickerPage.backToTopPage()
        // then
        XCTAssert(homePage.numberOfSelecttedPoems(is: 20))
    }
    
    func test_add20ofColor() {
        // given
        let pickPage = homePage.goToPoemPickerPage()
        XCTContext.runActivity(named: "1字決まりの札を選んでおく") { _ in
            pickPage.cancelAllButton.tap()
            let ngramPage = pickPage.gotoNgramPickerPage()
            ngramPage
                .tapCell(type: .justOne)
                .backToPickerButton.tap()
        }
        // when
        XCTContext.runActivity(named: "そこに、五色百人一首の黄色セットを追加する") { _ in
            let colorsPage = pickPage.gotoFiveColorsPage()
            let sheet = colorsPage.tapColorButton(of: .yellow)
            sheet.addThese20Button.tap()
            // then
            XCTAssert(colorsPage.badge(of: 24).exists)
            // when
            colorsPage.backButton.tap()
            pickPage.backToTopPage()
        }
        // then
        XCTAssert(homePage.numberOfSelecttedPoems(is: 24), "黄色の20枚には一字決まりの歌が3首含まれているので、足すと27枚ではなく24枚になる")
    }
    
    func test_select2colors() {
        // given
        let pickerPage = homePage.goToPoemPickerPage()
        let colorsPage = pickerPage.gotoFiveColorsPage()
        // when
        let sheet1 = colorsPage.tapColorButton(of: .green)
        sheet1.selectOnlyThese20Button.tap()
        let sheet2 = colorsPage.tapColorButton(of: .pink)
        sheet2.addThese20Button.tap()
        // then
        XCTAssert(colorsPage.badge(of: 40).exists)
        // when
        colorsPage.backButton.tap()
        pickerPage.backToTopPage()
        // then
        XCTAssert(homePage.numberOfSelecttedPoems(is: 40))
    }
    
}

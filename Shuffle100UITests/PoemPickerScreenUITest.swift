//
//  PoemPickerScreenUITest.swift
//  Shuffle100UITests
//
//  Created by 里 佳史 on 2019/12/14.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

class PoemPickerScreenUITest: XCTestCase, SHDeviceTypeGetter {
    let app = XCUIApplication()
    lazy var homePage = HomePage(app: app)
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    func test_cancelAllAndSelectAll() {
        XCTContext.runActivity(named: "「全て取消」ボタンを押すと、選ばれている歌が0首になる") { activity in
            // given
            let pickerPage = homePage.goToPoemPickerPage()
            XCTAssert(pickerPage.badge(of: 100).exists)
            // when
            pickerPage.cancelAllButton.tap()
            // then
            XCTAssert(pickerPage.badge(of: 0).exists)
            // when
            pickerPage.backToTopPage()
            // then
            XCTAssert(homePage.numberOfSelecttedPoems(is: 0))
        }
        XCTContext.runActivity(named: "そこから「全て選択」ボタンを押すと、選ばれている歌が100首になる") { activity in
            // when
            let pickerPage = homePage.goToPoemPickerPage()
            pickerPage.selectAllButton.tap()
            // then
            XCTAssert(pickerPage.badge(of: 100).exists)
        }
    }
    
    func test_tappingDetailButtonShowsTorifudaScreen() {
        // when
        let pickerPage = homePage.goToPoemPickerPage()
        let torifudaPage = pickerPage.tapDetailButtonOf(number: 1)
        // then
        XCTAssert(torifudaPage.exists)
        XCTAssert(torifudaPage.hasChar("わ"))
        XCTAssertFalse(torifudaPage.hasChar("き"))
    }
    
    func test_longPressNetRespondAnyMore() {
        // when
        let pickerPage = homePage.goToPoemPickerPage()
        pickerPage.longPress(number: 1)
        // then
        let torifudaPage = TorifudaPage(app: app)
        XCTAssertFalse(torifudaPage.exists)
    }
    
    func test_tapDetailButtonOnSearchResult() {
        // when
        let pickerPage = homePage.goToPoemPickerPage()
        // then
        let searchField = pickerPage.searchField
        XCTAssert(searchField.exists)
        // when
        searchField.tap()
        searchField.typeText("はる")
        let firstCell = pickerPage.firstCellInList
        let torifudaPage = pickerPage.tapDetailButton(of: firstCell)
        // then
        XCTAssert(torifudaPage.hasChar("ほ"))
        XCTAssertFalse(torifudaPage.hasChar("わ"))
        // when
        torifudaPage.backToPickerButton.tap()
        // then
        XCTAssertFalse(pickerPage.cellOf(number: 1).exists, "検索中だった状態が保持されている")
    }
    
    func test_torifudaShowsFullLinersOnPhoneTypeDevice() {
        // when
        let pickerPage = homePage.goToPoemPickerPage()
        let torifudaPage = pickerPage.tapDetailButtonOf(number: 1)
        // then
        if deviceType == .phone {
            XCTAssert(torifudaPage.fullLinersView.exists)
        } else {
            XCTAssertFalse(torifudaPage.fullLinersView.exists)
        }
    }
}

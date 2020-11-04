//
//  PoemPickerScreenUITest.swift
//  Shuffle100UITests
//
//  Created by 里 佳史 on 2019/12/14.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

class PoemPickerScreenUITest: XCTestCase, HomeScreenUITestUtils, SHDeviceTypeGetter {
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    func test_cancelAllAndSelectAll() {
        XCTContext.runActivity(named: "「全て取消」ボタンを押すと、選ばれている歌が0首になる") { activity in
            // given
            gotoPoemPickerScreen(app)
            // when
            sleep(1)
            app.buttons["全て取消"].tap()
            app.navigationBars["歌を選ぶ"].buttons["トップ"].tap()
            // then
            XCTAssertTrue(app.cells.staticTexts["0首"].exists)
        }
        XCTContext.runActivity(named: "そこから「全て選択」ボタンを押すと、選ばれている歌が100首になる") { activity in
            // given
            gotoPoemPickerScreen(app)
            // when
            sleep(1)
            app.buttons["全て選択"].tap()
            app.navigationBars["歌を選ぶ"].buttons["トップ"].tap()
            // then
            XCTAssertTrue(app.cells.staticTexts["100首"].exists)
        }
    }
    
    func test_tappingDetailButtonShowsFudaScreen() {
        // given
        gotoPoemPickerScreen(app)
        // when
        detailButtonOfCell(app.cells["001"]).tap()
        // then
        XCTAssert(app.staticTexts["わ"].exists)
        XCTAssertFalse(app.staticTexts["き"].exists)
    }
    
    func test_longPressNetRespondAnyMore() {
        // given
        gotoPoemPickerScreen(app)
        // when
        app.cells["001"].press(forDuration: 2.0)
        // then
        XCTAssertFalse(app.staticTexts["わ"].exists)
    }
    
    func test_tapDetailButtonOnSearchResult() {
        // given
        gotoPoemPickerScreen(app)
        // when
        let searchField = app.searchFields.element
        searchField.tap()
        searchField.typeText("はる")
        let firstCell = app.cells.firstMatch
        detailButtonOfCell(firstCell).tap()
        // then
        XCTContext.runActivity(named: "「ころもほすてふ」の取り札が表示される") { _ in
            XCTAssert(app.staticTexts["ほ"].exists)
            XCTAssertFalse(app.staticTexts["わ"].exists)
        }
        XCTContext.runActivity(named: "そこから「歌」を選ぶ画面に戻ると、検索中だった状態が保持されている") { _ in
            // when
            app.navigationBars.buttons.firstMatch.tap()
            // then
            XCTAssertFalse(app.cells["001"].exists)
        }
    }
    
    func test_torifudaShowsFullLinersOnPhoneTypeDevice() {
        // given
        gotoPoemPickerScreen(app)
        // when
        detailButtonOfCell(app.cells["001"]).tap()
        // then
        if deviceType == .phone {
            XCTAssert(app.textViews["fullLinersView"].exists)
        } else {
            XCTAssertFalse(app.textViews["fullLinersView"].exists)
        }
    }
    
    private func detailButtonOfCell(_ cellElement: XCUIElement) -> XCUIElement {
        return cellElement.buttons["詳細情報"]
    }
}

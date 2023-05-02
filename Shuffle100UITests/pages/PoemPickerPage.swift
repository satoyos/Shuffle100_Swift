//
//  PoemPickerPage.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/04/05.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import Foundation
import XCTest

final class PoemPickerPage: PageObjectable, WaitInUITest {
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var pageTitle: XCUIElement {
        app.navigationBars[A11y.title].firstMatch
    }
    
    var backToTopButton: XCUIElement {
        app.navigationBars.buttons[A11y.backToTop].firstMatch
    }
    
    var searchField: XCUIElement {
        app.searchFields[A11y.searchFieldPlaceHolder].firstMatch
    }
    
    var cancelButton: XCUIElement {
        app.buttons[A11y.cancel].firstMatch
    }
    
    var cancelAllButton: XCUIElement {
        waitToHittable(for: app.buttons[A11y.cancelAll], timeout: timeOutSec)
    }
    
    var selectAllButton: XCUIElement {
        waitToHittable(for: app.toolbars.buttons[A11y.selectAll], timeout: timeOutSec)
    }
    
    var selectByGroupButton: XCUIElement {
        waitToHittable(for: app.toolbars.buttons[A11y.selectByGroup].firstMatch, timeout: timeOutSec)
    }
    
    var saveButton: XCUIElement {
        app.navigationBars.buttons[A11y.save].firstMatch
    }
    
    var firstCellInList: XCUIElement {
        app.cells.firstMatch
    }
    
    enum A11y {
        static let title = "歌を選ぶ"
        static let backToTop = "トップ"
        static let searchFieldPlaceHolder = "歌を検索"
        static let cancel = "キャンセル"
        static let cancelAll = "全て取消"
        static let selectAll = "全て選択"
        static let selectByGroup = "まとめて選ぶ"
        static let save = "保存"
        static let detail = "詳細情報"
    }
    
    func badge(of number: Int) -> XCUIElement {
        app.navigationBars.staticTexts["\(number)首"]
    }
    
    @discardableResult
    func tapCellof(number: Int) -> Self {
        let a11yId = String(format: "%03d", number)
        let cell = app.cells[a11yId].firstMatch
        XCTAssert(cell.exists)
        cell.tap()
        return self
    }
    
    @discardableResult
    func tapDetailButtonOf(number: Int) -> TorifudaPage {
        tapDetailButton(of: cellOf(number: number))
    }
    
    @discardableResult
    func tapDetailButton(of cell: XCUIElement) -> TorifudaPage {
        cell.buttons[A11y.detail].tap()
        return TorifudaPage(app: app)
    }
    
    @discardableResult
    func backToTopPage() -> HomePage {
        backToTopButton.tap()
        let homePage = HomePage(app: app)
        XCTAssert(homePage.exists, "トップ画面に戻った")
        return homePage
    }
    
    func cellOf(number: Int) -> XCUIElement {
        let label = String(format: "%03d", number)
        return app.tables.cells[label].firstMatch
    }
    
    func longPress(number: Int) {
        cellOf(number: number).press(forDuration: 2.0)
    }
    
    @discardableResult
    func gotoNgramPickerPage() -> NgramPickerPage {
        let sheet = showSelectByGroupActionSheet()
        sheet.selectByNgramButton.tap()
        return NgramPickerPage(app: app)
    }
    
    @discardableResult
    func gotoDigitsPickerPage() -> DigitsPickerPage {
        let sheet = showSelectByGroupActionSheet()
        sheet.selectByDigitsButton.tap()
        return DigitsPickerPage(app: app)
    }
    
    func showSelectByGroupActionSheet() -> SelectByGroupActionSheet {
        selectByGroupButton.tap()
        return SelectByGroupActionSheet(app: app)
    }
    
    @discardableResult
    func saveCurrentPoemsAsNewSet(name: String) -> Self {
        // when
        saveButton.tap()
        let sheet = SaveFudaSetActionSheet(app: app)
        let button = waitToHittable(for: sheet.saveNewFudaSetButton, timeout: timeOutSec)
        button.tap()
        // then
        let alert = NameNewFudaSetAlert(app: app)
        XCTAssert(alert.exists, "新しい札セットを命名するダイアログが現れる")
        // when
        alert.textField.tap()
        alert.textField.typeText(name)
        alert.confirmButton.tap()
        // then
        let compAlert = SaveNewSetCompletedAlert(app: app)
        XCTAssert(compAlert.exists, "保存が完了した旨のダイアログが現れる")
        // when
        compAlert.confirmButton.tap()
        // then
        XCTAssertFalse(compAlert.exists, "確認ダイアログは消えている")
        // and
        return self
    }
    
    
}

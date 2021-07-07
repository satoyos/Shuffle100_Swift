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
        return app.navigationBars[A11y.title].firstMatch
    }
    
    var backToTopButton: XCUIElement {
        return app.navigationBars.buttons[A11y.backToTop].firstMatch
    }
    
    var searchField: XCUIElement {
        return app.searchFields[A11y.searchFieldPlaceHolder].firstMatch
    }
    
    var cancelButton: XCUIElement {
        return app.buttons[A11y.cancel].firstMatch
    }
    
    var cancelAllButton: XCUIElement {
        return waitToHittable(for: app.buttons[A11y.cancelAll], timeout: timeOutSec)
    }
    
    var selectAllButton: XCUIElement {
        return waitToHittable(for: app.toolbars.buttons[A11y.selectAll], timeout: timeOutSec)
    }
    
    var selectByGroupButton: XCUIElement {
        return waitToHittable(for: app.toolbars.buttons[A11y.selectByGroup].firstMatch, timeout: timeOutSec)
    }
    
    var saveButton: XCUIElement {
        return app.navigationBars.buttons[A11y.save].firstMatch
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
    func backToTopPage() -> HomePage {
        backToTopButton.tap()
        let homePage = HomePage(app: app)
        XCTAssert(homePage.exists, "トップ画面に戻った")
        return homePage
    }
    
    func cellOf(number: Int) -> XCUIElement {
        let label = String(format: "%03d", number)
        return app.tables.cells[label]
    }
    
    @discardableResult
    func gotoNgramPickerPage() -> NgramPickerPage {
        let sheet = showSelectByGroupActionSheet()
        sheet.selectByNgramButton.tap()
        return NgramPickerPage(app: app)
    }
    
    func showSelectByGroupActionSheet() -> SelectByGroupActionSheet {
        selectByGroupButton.tap()
        return SelectByGroupActionSheet(app: app)
    }
    
}

//
//  PoemPickerPage.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/04/05.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import Foundation
import XCTest

final class PoemPickerPage: PageObjectable {
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
    
    enum A11y {
        static let title = "歌を選ぶ"
        static let backToTop = "トップ"
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
}

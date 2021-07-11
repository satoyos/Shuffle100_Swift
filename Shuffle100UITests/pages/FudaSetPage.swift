//
//  FudaSetPage.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/07/05.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import Foundation
import XCTest

final class FudaSetPage: PageObjectable {
    let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }
    
    var pageTitle: XCUIElement {
        return app.navigationBars[A11y.title].firstMatch
    }
    
    var backButton: XCUIElement {
        return app.buttons[A11y.back].firstMatch
    }

    enum A11y {
        static let title = "作った札セットから選ぶ"
        static let back = "歌を選ぶ" // 画面上の見かけと違うんだけど、どうしてだろう？ 2021/07/11
    }
    
    func fudaSetCell(name: String) -> XCUIElement {
        return app.tables.cells.staticTexts[name].firstMatch
    }
    
    func selectFudaSetCell(name: String) -> Self {
        let cell = app.tables.cells.staticTexts[name].firstMatch
        cell.tap()
        return self
    }
}

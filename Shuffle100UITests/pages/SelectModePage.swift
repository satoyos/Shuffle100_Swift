//
//  SelectModePage.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/04/13.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import Foundation
import XCTest

final class SelectModePage: PageObjectable {
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var pageTitle: XCUIElement {
        return app.staticTexts[A11y.title].firstMatch
    }
    
    enum A11y {
        static let title = "読み上げモードを選ぶ"
    }
}

//
//  ConfirmPostMortemDialog.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/08/14.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import XCTest

final class ConfirmPostMortemDialog: AlertObjectable {
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var title: XCUIElement {
        app.alerts.staticTexts[A11y.title].firstMatch
    }
    
    var confirmButton: XCUIElement {
        app.alerts.buttons[A11y.confirm].firstMatch
    }
    
    var cancelButton: XCUIElement {
        app.alerts.buttons[A11y.cancel].firstMatch
    }
    
    enum A11y {
        static let title = "感想戦を始めますか？"
        static let confirm = "始める"
        static let cancel = "キャンセル"
    }
}

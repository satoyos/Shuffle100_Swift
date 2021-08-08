//
//  OverwriteSetCompletedDialog.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/08/08.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import XCTest

final class OverwriteSetCompletedDialog: AlertObjectable {
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var title: XCUIElement {
        return app.alerts.staticTexts[A11y.title].firstMatch
    }
    
    var confirmButton: XCUIElement {
        return app.alerts.buttons[A11y.confirm].firstMatch
    }
    
    enum A11y {
        static let title = "上書き完了"
        static let confirm = "OK"
    }
}

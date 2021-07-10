//
//  nameNewFudaSetAlert.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/07/10.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import Foundation
import XCTest

final class NameNewFudaSetAlert: AlertObjectable {
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var cancelButton: XCUIElement {
        return app.alerts.buttons[A11y.cancel].firstMatch
    }
    
    var confirmButton: XCUIElement {
        return app.alerts.buttons[A11y.confirm].firstMatch
    }
    
    var title: XCUIElement {
        return app.alerts.staticTexts[A11y.title].firstMatch
    }
    
    var textField: XCUIElement {
        return app.alerts.textFields[A11y.textField].firstMatch
    }
    
    enum A11y {
        static let title = "新しい札セットの名前"
        static let cancel = "キャンセル"
        static let confirm = "決定"
        static let textField = "札セットの名前"
    }
}

//
//  NoNameGivenForFudaSetAlert.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/07/25.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import Foundation
import XCTest

final class NoNameGivenForFudaSetAlert: AlertObjectable {
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var title: XCUIElement {
        return app.alerts.staticTexts[A11y.title].firstMatch
    }
    
    var dismissButton: XCUIElement {
        return app.alerts.buttons[A11y.dismiss].firstMatch
    }
    
    enum A11y {
        static let title = "新しい札セットの名前を決めましょう"
        static let dismiss = "戻る"
    }
}


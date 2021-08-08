//
//  SaveCompletedAlert.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/07/10.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import Foundation
import XCTest

final class SaveNewSetCompletedAlert: AlertObjectable {
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var title: XCUIElement {
        return app.alerts.staticTexts[A11y.title].firstMatch
    }
    
    var confirmButton: XCUIElement {
        return app.alerts.buttons[A11y.ok].firstMatch
    }
    
    enum A11y {
        static let title = "保存完了"
        static let ok = "OK"
    }
}

//
//  NoPoemToSaveAlert.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/07/25.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import Foundation
import XCTest

final class NoPoemToSaveAlert: AlertObjectable {
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
        static let title = "歌を選びましょう"
        static let dismiss = "戻る"
    }
}

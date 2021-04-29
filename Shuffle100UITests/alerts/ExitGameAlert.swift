//
//  ExitGameAlert.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/04/29.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import Foundation
import XCTest

final class ExitGameAlert: AlertObjectable, WaitInUITest {
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
    
    var cancelButton: XCUIElement {
        return app.alerts.buttons[A11y.cancel].firstMatch
    }
    
    enum A11y{
        static let confirm = "終了する"
        static let cancel = "続ける"
        static let title = "試合を終了しますか？"
    }
   
    func exitGameAndBackToTopPage() -> HomePage {
        confirmButton.tap()
        return HomePage(app: app)
    }
}

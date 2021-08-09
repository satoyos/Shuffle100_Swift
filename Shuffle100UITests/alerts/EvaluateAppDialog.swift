//
//  EvaluateAppDialog.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/08/09.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import XCTest

final class EvaluateAppDialog: AlertObjectable {
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var title: XCUIElement {
        return app.alerts.staticTexts[A11y.title].firstMatch
    }
    
    enum A11y {
        static let title = "このアプリを評価するために、App Storeアプリを立ち上げますか？"
    }
}

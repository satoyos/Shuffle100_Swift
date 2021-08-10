//
//  FiveColorsPage.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/08/10.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import XCTest

final class FiveColorsPage: PageObjectable {
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var pageTitle: XCUIElement {
        return app.navigationBars[A11y.title].firstMatch
    }
    
    enum A11y {
        static let title = "五色百人一首"
    }
}

//
//  FudaSetPage.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/07/05.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import Foundation
import XCTest

final class FudaSetPage: PageObjectable {
    let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }
    
    var pageTitle: XCUIElement {
        return app.navigationBars[A11y.title].firstMatch
    }

    enum A11y {
        static let title = "作った札セットから選ぶ"
    }
}

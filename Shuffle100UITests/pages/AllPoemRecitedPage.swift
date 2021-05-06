//
//  AllPoemRecitedPage.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/05/06.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import Foundation
import XCTest

final class AllPoemRecitedPage: PageObjectable {
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var pageTitle: XCUIElement {
        return app.staticTexts[A11y.title].firstMatch
    }
    
    var backToTopButton: XCUIElement {
        return app.buttons[A11y.backToTop].firstMatch
    }
    
    enum A11y {
        static let title = "試合終了"
        static let backToTop = "トップに戻る"
    }
    
    
}

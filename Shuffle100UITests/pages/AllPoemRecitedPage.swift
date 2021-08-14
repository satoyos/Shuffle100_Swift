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
        app.staticTexts[A11y.title].firstMatch
    }
    
    var backToTopButton: XCUIElement {
        app.buttons[A11y.backToTop].firstMatch
    }
    
    var postMortemButton: XCUIElement {
        app.buttons[A11y.postMortem].firstMatch
    }
    
    enum A11y {
        static let title = "試合終了"
        static let backToTop = "トップに戻る"
        static let postMortem = "感想戦を始める"
    }
    
    
}

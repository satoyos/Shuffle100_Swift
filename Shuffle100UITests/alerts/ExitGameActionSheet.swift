//
//  ExitGameActionSheet.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/08/15.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import XCTest

final class ExitGameActionSheet: AlertObjectable {
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var title: XCUIElement {
        app.scrollViews.staticTexts[A11y.title].firstMatch
    }
    
    var postMortemAButton: XCUIElement {
        app.scrollViews.buttons[A11y.postMortem].firstMatch
    }
    
    var backToTopButton: XCUIElement {
        app.scrollViews.buttons[A11y.backToTop].firstMatch
    }
    
    enum A11y {
        static let title = "感想戦を始めますか？"
        static let postMortem = "感想戦を始める"
        static let backToTop = "トップに戻る"
    }
}

//
//  RecitePoiemPage.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/04/10.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import Foundation
import XCTest

final class RecitePoemPage: PageObjectable {
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var pageTitle: XCUIElement {
        return app.staticTexts[A11y.titleIdentifier].firstMatch
    }
    
    var jokaTitle: XCUIElement {
        return app.staticTexts[A11y.jokaTitle].firstMatch
    }
    
    var exitGameButton: XCUIElement {
        return app.buttons[A11y.exitGame].firstMatch
    }
    
    enum A11y {
        static let titleIdentifier = "screenTitle"
        static let jokaTitle = "序歌"
        static let exitGame = "exit"
    }
    
}

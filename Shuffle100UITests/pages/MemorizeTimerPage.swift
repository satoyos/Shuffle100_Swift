//
//  MemorizeTimerPage.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/08/21.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import XCTest

final class MemorizeTimerPage: PageObjectable {
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var pageTitle: XCUIElement {
        app.navigationBars[A11y.title].firstMatch
    }
    
    var timeIsInitialValue: Bool {
        app.staticTexts[A11y.initialMinutes].exists
    }
    
    var buttonToPlay: XCUIElement {
        // UIKit version
//        app.buttons.staticTexts[stringExpression(of: .play)].firstMatch
        // SwiftUI Version
        app.buttons[A11y.play].firstMatch
    }
    
    var buttonToPause: XCUIElement {
        // UIKit Version
//        app.buttons.staticTexts[stringExpression(of: .pause)].firstMatch
        // SwiftUI Version
        app.buttons[A11y.pause].firstMatch
    }
    
    enum A11y {
        static let title = "暗記時間タイマー"
        static let initialMinutes = "15"
        static let play = "play"
        static let pause = "pause"
    }
    
    
}

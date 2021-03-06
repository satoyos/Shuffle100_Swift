//
//  RecitePoiemPage.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/04/10.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import Foundation
import XCTest

final class RecitePoemPage: PageObjectable, WaitInUITest {
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
    
    var playButton: XCUIElement {
        return app.buttons[A11y.play].firstMatch
    }
    
    var forwardButton: XCUIElement {
        return app.buttons[A11y.forward].firstMatch
    }
    
    var gearButton: XCUIElement {
        return app.buttons[A11y.gear].firstMatch
    }
    
    var normalJokaDescLabel: XCUIElement {
        return app.staticTexts[A11y.normalJokaDesc].firstMatch
    }
    
    var shortJokaDescLabel: XCUIElement {
        return app.staticTexts[A11y.shortJokaDesc].firstMatch
    }
    
    enum A11y {
        static let titleIdentifier = "screenTitle"
        static let jokaTitle = "序歌"
        static let exitGame = "exit"
        static let forward = "forward"
        static let play = "play"
        static let gear = "gear"
        static let normalJokaDesc = "試合開始の合図として読まれる歌です。"
        static let shortJokaDesc = "序歌を途中から読み上げています。"
    }
    
    func recitePageAppears(number: Int, side: Side, total: Int = 100) -> Bool {
        var headerText = ""
        switch side {
        case .kami:
            headerText = "\(number)首め:上の句 (全\(total)首)"
        case .shimo:
            headerText = "\(number)首め:下の句 (全\(total)首)"
        }
        return elementsExist([app.staticTexts[headerText]], timeout: timeOutSec)
    }
    
    func popUpExitGameAlert() -> ExitGameAlert {
        exitGameButton.tap()
        return ExitGameAlert(app: app)
    }
    
    func gotoSettingsPage() -> ReciteSettingsPage {
        gearButton.tap()
        return ReciteSettingsPage(app: app)
    }
    
    @discardableResult
    func tapForwardButton() -> Self {
        forwardButton.tap()
        return self
    }
}

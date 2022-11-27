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
        app.staticTexts[A11y.titleIdentifier].firstMatch
    }
    
    var jokaTitle: XCUIElement {
        app.staticTexts[A11y.jokaTitle].firstMatch
    }
    
    var exitGameButton: XCUIElement {
        app.buttons[A11y.exitGame].firstMatch
    }
    
    var playButton: XCUIElement {
        app.buttons[A11y.play].firstMatch
    }
    
    var forwardButton: XCUIElement {
        app.buttons[A11y.forward].firstMatch
    }
    
    var rewindButton: XCUIElement {
        app.buttons[A11y.rewind].firstMatch
    }
    
    var gearButton: XCUIElement {
        app.buttons[A11y.gear].firstMatch
    }
    
    var normalJokaDescLabel: XCUIElement {
        app.staticTexts[A11y.normalJokaDesc].firstMatch
    }
    
    var shortJokaDescLabel: XCUIElement {
        app.staticTexts[A11y.shortJokaDesc].firstMatch
    }
    
    var isWaitinfForPlay: Bool {
        app.buttons[A11y.waitingForPlay].exists
    }
    
    var isWaitingForPause: Bool {
        app.buttons[A11y.waitingForPause].exists
    }
       
    enum A11y {
        static let titleIdentifier = "screenTitle"
        static let jokaTitle = "序歌"
        static let exitGame = "exit"
        static let forward = "forward"
        static let rewind = "rewind"
        static let play = "play"
        static let gear = "gear"
        static let headerTitle = "screenTitle"
        static let normalJokaDesc = "試合開始の合図として読まれる歌です。"
        static let shortJokaDesc = "序歌を途中から読み上げています。"
        static let waitingForPlay = "waitingForPlay"
        static let waitingForPause = "waitingForPause"
    }
    
    func isReciting(number: Int, side: Side, total: Int = 100) -> Bool {
        var headerText = ""
        switch side {
        case .kami:
            headerText = "\(number)首め:上の句 (全\(total)首)"
        case .shimo:
            headerText = "\(number)首め:下の句 (全\(total)首)"
        }
//        return elementsExist([app.staticTexts[headerText]], timeout: timeOutSec)
        return headerText == headerTitleString
    }
    
    var headerTitleString: String {
        let titleLabel = app.staticTexts[A11y.headerTitle].firstMatch
        guard titleLabel.exists
        else {
            XCTFail("Couldn't get header title label of RecitePoemView")
            return "Test Failure"
        }
        return titleLabel.label
    }
    
    var isRecitingJoka: Bool {
        waitToAppear(for: jokaTitle, timeout: timeOutSec)
        return true
    }
    
    func popUpExitGameDialog() -> ExitGameDialog {
        exitGameButton.tap()
        return ExitGameDialog(app: app)
    }
    
    func gotoSettingsPage() -> ReciteSettingsPage {
        gearButton.tap()
        return ReciteSettingsPage(app: app)
    }
    
    @discardableResult
    func tapForwardButton() -> Self {
        let button = waitToHittable(for: forwardButton, timeout: timeOutSec)
        button.tap()
        return self
    }
    
    @discardableResult
    func tapRewindButton() -> Self {
        let button = waitToHittable(for: rewindButton, timeout: timeOutSec)
        button.tap()
        return self
    }
}

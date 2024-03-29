//
//  ReciteSettingsPage.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/06/01.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import Foundation
import XCTest

final class ReciteSettingsPage: PageObjectable, WaitInUITest, DigitText {
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var pageTitle: XCUIElement {
        return app.navigationBars[A11y.title].firstMatch
    }
    
    var intervalCell: XCUIElement {
        return app.cells[A11y.interval].firstMatch
    }
    
    var kamiShimoIntervalCell: XCUIElement {
        app.cells[A11y.kamiShimoInterval].firstMatch
    }
    
    var volumeCell: XCUIElement {
        app.cells[A11y.volume].firstMatch
    }
    
    var exitSettingsButton: XCUIElement {
        app.navigationBars.buttons[A11y.exitSetting].firstMatch
    }
    
    var fullVolumeLabel: XCUIElement {
        app.cells.staticTexts[A11y.fullVolume].firstMatch
    }
    
    var zeroVolumeLabel: XCUIElement {
        app.cells.staticTexts[A11y.zeroVolume].firstMatch
    }
    
    var maxIntarvalLabel: XCUIElement {
        app.cells.staticTexts[A11y.maxInterval].firstMatch
    }
    
    var shortenJokaModeSwitch: XCUIElement {
        app.cells.switches[A11y.shortenJokaSwitch].firstMatch
    }
    
    var posrMortemSwitch: XCUIElement {
        app.cells.switches[A11y.portMortemSwitch].firstMatch
    }
    
    enum A11y {
        static let title = "いろいろな設定"
        static let interval = "歌と歌の間隔"
        static let kamiShimoInterval = "上の句と下の句の間隔"
        static let volume = "音量調整"
        static let fullVolume = "100%"
        static let zeroVolume = "0%"
        static let maxInterval = "2.00" + "秒"
        static let exitSetting = "設定終了"
        static let shortenJokaSwitch = "shortenJokaModeSwitch"
        static let portMortemSwitch = "postMortemModeSwitch"
    }
    
    func gotoIntervalSettingPage() -> IntervalSettingPage {
        let cell = waitToHittable(for: intervalCell, timeout: timeOutSec)
        cell.tap()
        return IntervalSettingPage(app: app)
    }
    
    func gotoKamiShimoIntervalPage() -> KamiShimoIntervalPage {
        kamiShimoIntervalCell.tap()
        return KamiShimoIntervalPage(app: app)
    }
    
    func gotoVolumePage() -> VolumePage {
        volumeCell.tap()
        return VolumePage(app: app)
    }
    
    @discardableResult
    func switchPostMortemMode() -> Self {
        posrMortemSwitch.tap()
        return self
    }
}

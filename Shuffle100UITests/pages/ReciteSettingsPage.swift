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
    
    var exitSettingsButton: XCUIElement {
        return app.navigationBars.buttons[A11y.exitSetting].firstMatch
    }
    
    enum A11y {
        static let title = "いろいろな設定"
        static let interval = "歌と歌の間隔"
        static let exitSetting = "設定終了"
    }
    
    func gotoIntervalSettingPage() -> IntervalSettingPage {
        let cell = waitToHittable(for: intervalCell, timeout: timeOutSec)
        cell.tap()
        return IntervalSettingPage(app: app)
    }
}

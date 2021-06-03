//
//  KamiShimoIntervalPage.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/06/03.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import Foundation
import XCTest

final class KamiShimoIntervalPage: PageObjectable, DigitText, AdjustSlider {
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var pageTitle: XCUIElement {
        return app.navigationBars[A11y.title].firstMatch
    }
    
    var slider: XCUIElement {
        return app.sliders[A11y.slider].firstMatch
    }
    
    var tryButton: XCUIElement {
        return app.buttons[A11y.tryListening].firstMatch
    }
    
    var zeroSecLabel: XCUIElement {
        return app.staticTexts[A11y.zeroSec].firstMatch
    }
    
    var backToAllSettingsButton: XCUIElement {
        return app.navigationBars.buttons[A11y.backToAllSettings].firstMatch
    }
    
    enum A11y {
        static let title = "上の句と下の句の間隔"
        static let slider = "slider"
        static let tryListening = "試しに聞いてみる"
        static let zeroSec = "0.00"
        static let backToAllSettings = "いろいろな設定"
    }
}

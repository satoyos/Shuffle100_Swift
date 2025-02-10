//
//  VolumePage.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/06/04.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import Foundation
import XCTest

final class VolumePage: PageObjectable, WaitInUITest, AdjustSlider {
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var pageTitle: XCUIElement {
        return app.navigationBars[A11y.title].firstMatch
    }

    var slider: XCUIElement {
        return app.sliders.firstMatch
    }
    
    var backToAllSettingsButton: XCUIElement {
        return app.navigationBars.buttons[A11y.allSettings].firstMatch
    }

    enum A11y {
        static let title = "音量の調整"
        static let slider = "slider"
        static let allSettings = "いろいろな設定"
    }
}

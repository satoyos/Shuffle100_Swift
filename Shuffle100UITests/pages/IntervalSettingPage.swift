//
//  IntervalSettingPage.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/06/01.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import Foundation
import XCTest

final class IntervalSettingPage: PageObjectable, WaitInUITest, AdjustSlider {
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
    
    enum A11y {
        static let title = "歌の間隔の調整"
        static let slider = "slider"
    }
}

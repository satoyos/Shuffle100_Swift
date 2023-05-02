//
//  DigitsPickerPage.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2023/05/01.
//  Copyright © 2023 里 佳史. All rights reserved.
//

import Foundation
import XCTest

final class DigitsPickerPage: PageObjectable, WaitInUITest {
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var pageTitle: XCUIElement {
        app.navigationBars[A11y.title].firstMatch
    }
    
    enum A11y {
        static let title = "1の位、または10の位の数で選ぶ"
    }
}

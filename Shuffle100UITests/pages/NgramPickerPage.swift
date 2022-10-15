//
//  NgramPickerPage.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/07/03.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import Foundation
import XCTest

enum NgramCellType: String {
    case justOne = "just_one"
    case u = "u"
    case tsu = "tsu"
    case shi = "shi"
    case mo = "mo"
    case yu = "yu"
}

final class NgramPickerPage: PageObjectable {
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var pageTitle: XCUIElement {
        return app.navigationBars[A11y.title].firstMatch
    }
    
    var backToPickerButton: XCUIElement {
        return app.navigationBars.buttons[A11y.backToPicker].firstMatch
    }
    
    enum A11y {
        static let title = "1字目で選ぶ"
        static let backToPicker = "歌を選ぶ"
    }
    
    func badge(of number: Int) -> XCUIElement {
        app.navigationBars.staticTexts["\(number)首"]
    }
    
    @discardableResult
    func tapCell(type: NgramCellType) -> Self {
        cell(type: type).tap()
        return self
    }
    
    private func cell(type: NgramCellType) -> XCUIElement {
        return app.cells[type.rawValue].firstMatch
    }
}

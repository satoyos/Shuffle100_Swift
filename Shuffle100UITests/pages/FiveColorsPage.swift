//
//  FiveColorsPage.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/08/10.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import XCTest

final class FiveColorsPage: PageObjectable {
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var pageTitle: XCUIElement {
        app.navigationBars[A11y.title].firstMatch
    }
    
    var backButton: XCUIElement {
        app.navigationBars.buttons[A11y.back].firstMatch
    }
    
    enum A11y {
        static let title = "五色百人一首"
        static let back = "歌を選ぶ"
    }
    
    func badge(of number: Int) -> XCUIElement {
        app.navigationBars.staticTexts["\(number)首"]
    }
    
    private func colorButton(of color: FiveColors) -> XCUIElement {
        app.buttons[color.rawValue].firstMatch
    }
    
    @discardableResult
    func tapColorButton(of color: FiveColors) -> SelectedColorHanlingSheet {
        colorButton(of: color).tap()
        return  SelectedColorHanlingSheet(app: app)
    }
}

//
//  SelectSingerPage.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/04/16.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import Foundation
import XCTest

final class SelectSingerPage: PageObjectable {
    let app: XCUIApplication
    private let singerNames = ["IA（ボーカロイド）", "いなばくん（人間）"]
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var pageTitle: XCUIElement {
        return app.navigationBars.staticTexts[A11y.title].firstMatch
    }
    
    var backToTopButton: XCUIElement {
        return app.navigationBars.buttons[A11y.backToTop].firstMatch
    }
    
    func selectSingerFor(name: String) -> Self {
        if let formalName = singerNames.first(where: { $0.contains(name) }) {
            app.pickerWheels.element.adjust(toPickerWheelValue: formalName)
        } else {
            XCTFail("与えられた文字列を含む毒手が見つからない！")
        }
        return self
    }
    
    
    
    enum A11y {
        static let title = "読手を選ぶ"
        static let backToTop = "トップ"
    }
}

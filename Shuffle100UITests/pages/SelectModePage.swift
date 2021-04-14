//
//  SelectModePage.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/04/13.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import Foundation
import XCTest
// import Shuffle100

final class SelectModePage: PageObjectable {
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var pageTitle: XCUIElement {
        return app.navigationBars.staticTexts[A11y.title].firstMatch
    }
    
    var backToTopButton: XCUIElement {
        return app.navigationBars.buttons[A11y.backToTop].firstMatch
    }
    
    func selectBeginnerMode(_ mode: ReciteMode) -> Self {
        let label = labelForReciteMode(mode)
        app.pickerWheels.firstMatch.adjust(toPickerWheelValue: label)
        return self
    }
    
    private func labelForReciteMode(_ mode: ReciteMode) -> String {
        var label = ""
        switch mode {
        case .beginner:
            label = A11y.beginnrMode
        case .nonstop:
            label = A11y.nonStopMode
        case .normal:
            label = A11y.normalMode
        }
        return label
    }
    
    enum A11y {
        static let title = "読み上げモードを選ぶ"
        static let backToTop = "トップ"
        static let beginnrMode = "初心者 (チラし取り)"
        static let normalMode = "通常 (競技かるた)"
        static let nonStopMode = "ノンストップ (とまらない)"
    }
}

//
//  OverwriteSetSelectionActionSheet.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2025/08/29.
//  Copyright © 2025 里 佳史. All rights reserved.
//

import Foundation
import XCTest

final class OverwriteSetSelectionActionSheet: AlertObjectable, WaitInUITest {
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var title: XCUIElement {
        app.scrollViews.staticTexts[A11y.title].firstMatch
    }
    
    var cancelButton: XCUIElement {
        waitToHittable(for: app.scrollViews.buttons[A11y.cancel],
                       timeout: timeOutSec)
    }
    
    func fudaSetButton(name: String) -> XCUIElement {
        waitToHittable(for: app.scrollViews.buttons[name],
                       timeout: timeOutSec)
    }
    
    @discardableResult
    func selectFudaSet(name: String) -> Self {
        fudaSetButton(name: name).tap()
        return self
    }
    
    enum A11y {
        static let title = "上書きする札セットを選ぶ"
        static let cancel = "キャンセル"
    }
}
//
//  SaveFudaSetActionSheet.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/07/07.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import Foundation
import XCTest

final class SaveFudaSetActionSheet: AlertObjectable, WaitInUITest {
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
    
    var saveNewFudaSetButton: XCUIElement {
        waitToHittable(for: app.scrollViews.buttons[A11y.saveAsNewSet].firstMatch,
                       timeout: timeOutSec)
    }
    
    var overwriteExistingSetButton: XCUIElement {
        waitToHittable(for: app.scrollViews.buttons[A11y.overwriteExistingSet],
                       timeout: timeOutSec)
    }
    
    enum A11y {
        static let title = "選んでいる札をどのように保存しますか？"
        static let cancel = "キャンセル"
        static let saveAsNewSet = "新しい札セットとして保存する"
        static let overwriteExistingSet = "前に作った札セットを上書きする"
    }    
}

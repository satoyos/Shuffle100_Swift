//
//  SelectedColorHandlingSheet.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/08/13.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import XCTest

final class SelectedColorHanlingSheet: AlertObjectable, WaitInUITest{
    
    let app: XCUIApplication
    
    internal init(app: XCUIApplication) {
        self.app = app
    }
    
    // このActionSheetのタイトルは選んだ色ごとに変わるので、
    // ここでは必ず表示されるボタンをタイトル代わりに使う。
    var title: XCUIElement {
        selectOnlyThese20Button
    }
    
    var cancelButton: XCUIElement {
        waitToHittable(for: app.scrollViews.buttons[A11y.cancel], timeout: timeOutSec)
    }
    
    var selectOnlyThese20Button: XCUIElement {
        waitToHittable(for: app.scrollViews.buttons[A11y.selectOnlyThese20].firstMatch, timeout: timeOutSec)
    }
    
    var addThese20Button: XCUIElement {
        waitToHittable(for: app.scrollViews.buttons[A11y.addThese20].firstMatch, timeout: timeOutSec)
    }
    
    enum A11y {
        static let cancel = "キャンセル"
        static let selectOnlyThese20 = "この20首だけを選ぶ"
        static let addThese20 = "今選んでいる札に加える"
    }
}

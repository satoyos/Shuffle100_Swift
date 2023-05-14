//
//  SelectByGroupActionSheet.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/07/05.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import Foundation
import XCTest

final class SelectByGroupActionSheet: AlertObjectable, WaitInUITest {
    let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }
    
    var title: XCUIElement {
        app.scrollViews.staticTexts[A11y.title]
    }
    
    var cancelButton: XCUIElement {
        waitToHittable(for: app.scrollViews.buttons[A11y.cancel],
                       timeout: timeOutSec)
    }
    
    var selectByNgramButton: XCUIElement {
        waitToHittable(for: app.scrollViews.buttons[A11y.selectByNgram].firstMatch, timeout: timeOutSec)
    }
    
    var selectBySetButton: XCUIElement {
        waitToHittable(for: app.scrollViews.buttons[A11y.selectBySet].firstMatch, timeout: timeOutSec)
    }
    
    var selectByColorButton: XCUIElement {
        waitToHittable(for: app.scrollViews.buttons[A11y.selectByColor].firstMatch, timeout: timeOutSec)
    }
    
    var selectByDigits01Button: XCUIElement {
        waitToHittable(
            for: app.scrollViews
                .buttons[A11y.selectByDigits01].firstMatch,
            timeout: timeOutSec)
    }
    
    enum A11y {
        static let title = "どうやって選びますか？"
        static let cancel = "キャンセル"
        static let selectByNgram = "1字目で選ぶ"
        static let selectBySet = "作った札セットから選ぶ"
        static let selectByColor = "五色百人一首の色で選ぶ"
        static let selectByDigits01 = "1の位の数で選ぶ"
        static let selectByDigits10 = "10の位の数で選ぶ"
    }
}

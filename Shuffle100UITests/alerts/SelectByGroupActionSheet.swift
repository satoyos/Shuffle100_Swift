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
        return app.sheets.staticTexts[A11y.title].firstMatch
    }
    
    var cancelButton: XCUIElement {
        return waitToHittable(for: app.sheets.buttons[A11y.cancel], timeout: timeOutSec)
    }
    
    var selectByNgramButton: XCUIElement {
        return waitToHittable(for: app.sheets.buttons[A11y.selectByNgram].firstMatch, timeout: timeOutSec)
    }
    
    var selectBySetButton: XCUIElement {
        return waitToHittable(for: app.sheets.buttons[A11y.selectBySet].firstMatch, timeout: timeOutSec)
    }
    
    enum A11y {
        static let title = "どうやって選びますか？"
        static let cancel = "キャンセル"
        static let selectByNgram = "1字目で選ぶ"
        static let selectBySet = "作った札セットから選ぶ"
    }
    
}

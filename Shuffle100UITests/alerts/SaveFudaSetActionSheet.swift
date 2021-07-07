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
        return app.sheets.staticTexts[A11y.title].firstMatch
    }
    
    var cancelButton: XCUIElement {
        return waitToHittable(for: app.sheets.buttons[A11y.cancel], timeout: timeOutSec)
    }
    
    
    enum A11y {
        static let title = "選んでいる札をどのように保存しますか？"
        static let cancel = "キャンセル"
    }
    
    
}

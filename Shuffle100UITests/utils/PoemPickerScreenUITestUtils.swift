//
//  PemPickerScreenUITestUtils.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/02/21.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import Foundation
import XCTest

protocol PoemPickerScreenUITestUtils {
    func goBackToHomeScreen(_ app: XCUIApplication) -> Void
}

extension PoemPickerScreenUITestUtils {
    func goBackToHomeScreen(_ app: XCUIApplication) {
        app.navigationBars["歌を選ぶ"].buttons["トップ"].tap()
    }
}

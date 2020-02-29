//
//  SelectSingerScreenUITestUtils.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/02/29.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import Foundation
import XCTest

private let singerNames = ["IA（ボーカロイド）", "いなばくん（人間）"]

protocol SelectSingerScreenUITestUtils {
    func goBackToHomeScreen(_ app: XCUIApplication) -> Void
    func selectSingerFor(name: String, in app: XCUIApplication) -> Void
}

extension SelectSingerScreenUITestUtils {
    func goBackToHomeScreen(_ app: XCUIApplication) {
        app.navigationBars["読手を選ぶ"].buttons["トップ"].tap()
    }
    
    func selectSingerFor(name: String, in app: XCUIApplication) {
        if let formalName = singerNames.first(where: { $0.contains(name) }) {
            app.pickerWheels.element.adjust(toPickerWheelValue: formalName)
        } else {
            XCTFail("与えられた文字列を含む毒手が見つからない！")
        }
    }
}

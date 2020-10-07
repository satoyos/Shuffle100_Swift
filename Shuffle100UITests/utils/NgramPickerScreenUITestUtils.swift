//
//  NgramPickerScreenUITestUtils.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/06/06.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

protocol NgramPickerScreenTestUtils: PoemPickerScreenUITestUtils {
    func selectAll2maiFudaFromPoemPickerScreen(_ app: XCUIApplication)
    func select93Excluding1jiKimari(_ app: XCUIApplication)
    func select1jiKimari(_ app: XCUIApplication)
}

extension NgramPickerScreenTestUtils {
    func selectAll2maiFudaFromPoemPickerScreen(_ app: XCUIApplication) {
        XCTContext.runActivity(named: "全ての選択を外して、「1字目で選ぶ」画面へ移動する") { activity in
            let button = waitToHittable(for: app.buttons["全て取消"], timeout: 3)
            button.tap()
            gotoNgramPickerScreenFromPickerScreen(app)
        }
        // when
        app.cells["u"].tap()
        app.cells["tsu"].tap()
        app.cells["shi"].tap()
        app.cells["mo"].tap()
        app.cells["yu"].tap()
        goBackToPoemPickerScreen(app)
    }
    
    func select93Excluding1jiKimari(_ app: XCUIApplication) {
        XCTContext.runActivity(named: "全ての歌を選択する") { activity in
            let button = waitToHittable(for: app.buttons["全て選択"], timeout: timeOutSec)
            button.tap()
        }
        gotoNgramPickerScreenFromPickerScreen(app)
        app.cells["just_one"].tap()
        goBackToPoemPickerScreen(app)
    }
    
    func select1jiKimari(_ app: XCUIApplication) {
        let allCancelButton = waitToHittable(for: app.buttons["全て取消"], timeout: timeOutSec)
        allCancelButton.tap()
        gotoNgramPickerScreenFromPickerScreen(app)
        app.cells["just_one"].tap()
        goBackToPoemPickerScreen(app)
    }
}

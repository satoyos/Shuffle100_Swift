//
//  FudaSetsUITestUtils.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/06/06.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

fileprivate let saveNewFudaSetStr = "新しい札セットとして保存する"

protocol FudaSetsUITestUtils: PoemPickerScreenUITestUtils {
    func add97FudaSetAsNewOne(_ app: XCUIApplication, setName: String)
    func showActionSheetforFudaSetSaving(_ app: XCUIApplication)
    func selectSaveAsNewSet(_ app: XCUIApplication)
}

extension FudaSetsUITestUtils {
    func add97FudaSetAsNewOne(_ app: XCUIApplication, setName: String) {
        select97Excluding_1_2_4(app)
        showActionSheetforFudaSetSaving(app)
        selectSaveAsNewSet(app)
        XCTContext.runActivity(named: "表示されるダイアログで名前を入力して「決定」を押すと、「保存完了」ダイアログが表示される") { activity in
            // when
            app.alerts.textFields.element.tap()
            app.alerts.textFields.element.typeText(setName)
            app.buttons["決定"].tap()
            // then
            XCTAssert(app.alerts.staticTexts["保存完了"].exists)
            // when
            app.alerts.buttons["OK"].tap()
            // then
            XCTAssertFalse(app.alerts.staticTexts["保存完了"].exists)
        }
    }
    
    func showActionSheetforFudaSetSaving(_ app: XCUIApplication) {
        XCTContext.runActivity(named: "「保存」ボタンを押すと、アクションシートが現れる") { activity in
            // when
            app.buttons["保存"].tap()
            // then
            waitToAppear(for: app.staticTexts["選んでいる札をどのように保存しますか？"], timeout: 3)
            XCTAssert(app.buttons[saveNewFudaSetStr].exists)
            // iPadでは、ActionSheetでキャンセルボタンが表示されない。
            if UIDevice.current.userInterfaceIdiom == .phone {
                XCTAssert(app.buttons["キャンセル"].exists)
            }
        }
    }
    
    func selectSaveAsNewSet(_ app: XCUIApplication) {
        XCTContext.runActivity(named: "「新しい札セットとして保存」を選択すると、新セットの名前を入力するためのダイアログが現れる") { activity in
            // when
            app.buttons[saveNewFudaSetStr].tap()
            // then
            waitToAppear(for: app.staticTexts["新しい札セットの名前"], timeout: 2)
        }
    }
}

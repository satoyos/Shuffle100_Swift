//
//  FudaSetSavingUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/05/20.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class FudaSetSavingUITest: XCTestCase, HomeScreenUITestUtils {
    private var app = XCUIApplication()
    private let saveNewFudaSetStr = "新しい札セットとして保存する"
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }


    func test_showActionSheetForFudaSetSaving() throws {
        // given
        gotoPoemPickerScreen(app)
        // when, then
        showActionSheetforFudaSetSaving(app)
    }
    
    func test_saveNewFudaSet() {
        // given
        gotoPoemPickerScreen(app)
        showActionSheetforFudaSetSaving(app)
        selectSaveAsNewSet(app)
        XCTContext.runActivity(named: "表示されるダイアログで名前を入力して「決定」を押すと、「保存完了」ダイアログが表示される") { activity in
            // when
            app.alerts.textFields.element.tap()
            app.alerts.textFields.element.typeText("テスト札セット")
            app.buttons["決定"].tap()
            // then
            XCTAssert(app.alerts.staticTexts["保存完了"].exists)
            // when
            app.alerts.buttons["OK"].tap()
            // then
            XCTAssertFalse(app.alerts.staticTexts["保存完了"].exists)
        }
        XCTContext.runActivity(named: "保存済みの札セットがある状態でツールバーの「まとめて選ぶ」を選択すると、既存の札セットを呼び出す選択肢が現れる") { activity in
            // when
            app.toolbars.buttons["まとめて選ぶ"].tap()
            // then
            XCTAssert(app.sheets.buttons["作った札セットから選ぶ"].exists)
        }
        XCTContext.runActivity(named: "既存の札セットから選ぶアクションを選択すると、札セットの一覧画面が表示される") { _ in
            // when
            app.sheets.buttons["作った札セットから選ぶ"].tap()
            // then
            waitToAppear(for: app.navigationBars["作った札セットから選ぶ"], timeout: 3)
        }
    }
 

    func test_savingEmptyFudaSetIsInhibited() {
        // given
        gotoPoemPickerScreen(app)
        // when
        let button = waitToHittable(for: app.buttons["全て取消"], timeout: 3)
        button.tap()
        app.buttons["保存"].tap()
        // then
        XCTAssert(app.staticTexts["歌を選びましょう"].exists)
        // when
        app.buttons["戻る"].tap()
        // then
        XCTAssertFalse(app.staticTexts["歌を選びましょう"].exists)
    }
    
    func test_emptyFudaSetNameIsInhibited() {
        // given
        gotoPoemPickerScreen(app)
        showActionSheetforFudaSetSaving(app)
        selectSaveAsNewSet(app)
        // when
        app.buttons["決定"].tap()
        // then
        XCTAssert(app.staticTexts["新しい札セットの名前を決めましょう"].exists)
        app.buttons["戻る"].tap()
        // then
        XCTAssertFalse(app.staticTexts["新しい札セットの名前を決めましょう"].exists)
        XCTAssert(app.staticTexts["新しい札セットの名前"].exists)
    }
    
    private func showActionSheetforFudaSetSaving(_ app: XCUIApplication) {
        XCTContext.runActivity(named: "「保存」ボタンを押すと、アクションシートが現れる") { activity in
            // when
            app.buttons["保存"].tap()
            // then
            XCTAssert(app.staticTexts["選んでいる札をどのように保存しますか？"].exists)
            XCTAssert(app.buttons[saveNewFudaSetStr].exists)
            // iPadでは、ActionSheetでキャンセルボタンが表示されない。
            if UIDevice.current.userInterfaceIdiom == .phone {
                XCTAssert(app.buttons["キャンセル"].exists)
            }
        }
    }
    
    private func selectSaveAsNewSet(_ app: XCUIApplication) {
        XCTContext.runActivity(named: "「新しい札セットとして保存」を選択すると、新セットの名前を入力するためのダイアログが現れる") { activity in
            // when
            app.buttons[saveNewFudaSetStr].tap()
            // then
            waitToAppear(for: app.staticTexts["新しい札セットの名前"], timeout: 2)
        }
    }
}

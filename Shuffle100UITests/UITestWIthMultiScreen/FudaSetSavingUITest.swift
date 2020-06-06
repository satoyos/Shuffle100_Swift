//
//  FudaSetSavingUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/05/20.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class FudaSetSavingUITest: XCTestCase, HomeScreenUITestUtils, NgramPickerScreenTestUtils, FudaSetsUITestUtils {
    private var app = XCUIApplication()
//    private let saveNewFudaSetStr = "新しい札セットとして保存する"
    private let test97SetName = "97枚セット"

    
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
        // デフォルトの設定では全ての歌が選ばれている状態
        allPoemsAreSelectedAtHomeScreen(app)
        gotoPoemPickerScreen(app)
        // when
        add97FudaSetAsNewOne(app, setName: test97SetName)
        XCTContext.runActivity(named: "一旦全ての歌を選択した状態に戻し、トップ画面に戻ると、100首選ばれていることが確認できる") { _ in
            // when
            let button = waitToHittable(for: app.buttons["全て選択"], timeout: 2)
            button.tap()
            goBackToHomeScreen(app)
            allPoemsAreSelectedAtHomeScreen(app)
        }
        gotoPoemPickerScreen(app)
        XCTContext.runActivity(named: "保存済みの札セットがある状態でツールバーの「まとめて選ぶ」を選択すると、既存の札セットを呼び出す選択肢が現れる") { activity in
            // when
            let button = waitToHittable(for: app.toolbars.buttons["まとめて選ぶ"], timeout: 3)
            button.tap()
            // then
            XCTAssert(app.sheets.buttons["作った札セットから選ぶ"].exists)
        }
        XCTContext.runActivity(named: "既存の札セットから選ぶアクションを選択すると、札セットの一覧画面が表示される") { _ in
            // when
            app.sheets.buttons["作った札セットから選ぶ"].tap()
            // then
            waitToAppear(for: app.navigationBars["作った札セットから選ぶ"], timeout: 3)
            XCTAssert(app.cells.staticTexts[test97SetName].exists)
            XCTAssert(app.cells.staticTexts["97首"].exists)
        }
        XCTContext.runActivity(named: "選んだ既存の札セットの歌が選択された状態になっている") { _ in
            // when
            app.cells.staticTexts[test97SetName].tap()
            // then
            app.navigationBars.buttons["歌を選ぶ"].tap()
            goBackToHomeScreen(app)
            XCTAssert(app.cells.staticTexts["97首"].exists)
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
        let button = waitToHittable(for: app.buttons["戻る"], timeout: 3)
        XCTAssert(app.staticTexts["新しい札セットの名前を決めましょう"].exists)
        button.tap()
        // then
        XCTAssertFalse(app.staticTexts["新しい札セットの名前を決めましょう"].exists)
        XCTAssert(app.staticTexts["新しい札セットの名前"].exists)
    }
    
    func test_fudaSetCellDeletable() {
        // ToDo!!
    }
    
    private func allPoemsAreSelectedAtHomeScreen(_ app: XCUIApplication) {
        XCTAssert(app.cells.staticTexts["100首"].exists)
    }
}

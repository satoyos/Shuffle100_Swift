//
//  FudaSetSavingUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/05/20.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class FudaSetSavingUITest: XCTestCase, HomeScreenUITestUtils, FudaSetsUITestUtils {
    let selectBySetStr = "作った札セットから選ぶ"
    let overwriteExisingSetStr = "前に作った札セットを上書きする"
    
    internal let app = XCUIApplication()
    private let test97SetName = "97枚セット"
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }


    func test_showActionSheetForFudaSetSaving() throws {
        // given
        gotoPoemPickerScreen()
        // when, then
        showActionSheetforFudaSetSaving(app)
    }
    
    func test_saveNewFudaSet() {
        // given
        // デフォルトの設定では全ての歌が選ばれている状態
        allPoemsAreSelectedAtHomeScreen(app)
        gotoPoemPickerScreen()
        // when
        add97FudaSetAsNewOne(app, setName: test97SetName)
        XCTContext.runActivity(named: "一旦全ての歌を選択した状態に戻し、トップ画面に戻ると、100首選ばれていることが確認できる") { _ in
            // when
            let button = waitToHittable(for: app.buttons["全て選択"], timeout: timeOutSec)
            button.tap()
            goBackToHomeScreen(app)
            allPoemsAreSelectedAtHomeScreen(app)
        }
        gotoPoemPickerScreen()
        XCTContext.runActivity(named: "保存済みの札セットがある状態でツールバーの「まとめて選ぶ」を選択すると、既存の札セットを呼び出す選択肢が現れる") { activity in
            // when
            let button = waitToHittable(for: app.toolbars.buttons["まとめて選ぶ"], timeout: timeOutSec)
            button.tap()
            // then
            XCTAssert(app.sheets.buttons[selectBySetStr].exists)
        }
        XCTContext.runActivity(named: "既存の札セットから選ぶアクションを選択すると、札セットの一覧画面が表示される") { _ in
            // when
            app.sheets.buttons[selectBySetStr].tap()
            // then
            waitToAppear(for: app.navigationBars[selectBySetStr], timeout: timeOutSec)
            XCTAssert(app.cells.staticTexts[test97SetName].exists)
            XCTAssert(app.cells.staticTexts["97首"].exists)
        }
        XCTContext.runActivity(named: "選んだ既存の札セットの歌が選択された状態になっている") { _ in
            // when
            app.cells.staticTexts[test97SetName].tap()
            // then
            goBackToPoemPickerScreen(app)
            goBackToHomeScreen(app)
            XCTAssert(app.cells.staticTexts["97首"].exists)
        }
    }
 

    func test_savingEmptyFudaSetIsInhibited() {
        // given
        gotoPoemPickerScreen()
        // when
        let button = waitToHittable(for: app.buttons["全て取消"], timeout: timeOutSec)
        button.tap()
        app.buttons["保存"].tap()
        // then
        XCTAssert(app.alerts.staticTexts["歌を選びましょう"].exists)
        // when
        app.buttons["戻る"].tap()
        // then
        XCTAssertFalse(app.alerts.staticTexts["歌を選びましょう"].exists)
    }
    
    func test_emptyFudaSetNameIsInhibited() {
        // given
        gotoPoemPickerScreen()
        showActionSheetforFudaSetSaving(app)
        selectSaveAsNewSet(app)
        // when
        app.buttons["決定"].tap()
        // then
        let button = waitToHittable(for: app.buttons["戻る"], timeout: timeOutSec)
        XCTAssert(app.alerts.staticTexts["新しい札セットの名前を決めましょう"].exists)
        button.tap()
        // then
        XCTAssertFalse(app.staticTexts["新しい札セットの名前を決めましょう"].exists)
        XCTAssert(app.alerts.staticTexts["新しい札セットの名前"].exists)
    }
    
    
    //
    // このテストを実行するときには、SimulatorのI/O -> Keyboardの中の
    // "Connet Hardware Keyboard"のチェックを外しておくこと！
    // そうしないと、動作不定になる。
    //
    func test_fudaSetCellDeletable() {
        // given
        gotoPoemPickerScreen()
        let set97name = "97枚セット"
        let set2maiFudaName = "2枚札セット"
        add97FudaSetAsNewOne(app, setName: set97name)
        add2maiFudaSetAsNewOne(app, setName: set2maiFudaName)
        gotoFudaSetsScreenFromPoemPicker()
        XCTContext.runActivity(named: "札セットのセルを左にスワイプして削除ボタンをタップすると、そのセルが消える") { _ in
            let cell97 = app.cells.staticTexts[set97name]
            XCTAssert(cell97.exists)
            // when
            cell97.swipeLeft()
            app.tables.buttons["削除"].tap()
            // then
            XCTAssertFalse(cell97.exists)
            let cell2mai = app.cells.staticTexts[set2maiFudaName]
            XCTAssert(cell2mai.exists)
            // when
            cell2mai.swipeLeft()
            app.tables.buttons["削除"].tap()
            // then
            XCTAssertFalse(cell2mai.exists)
            goBackToPoemPickerScreen(app)
        }
        XCTContext.runActivity(named: "その後、さらに札セットを新規追加しても、正しく動作する") { _ in
            let name93 = "一字決まり以外！"
            add93FudaSetAsNewOne(app, setName: name93)
            gotoFudaSetsScreenFromPoemPicker()
            // then
            XCTAssert(app.cells.staticTexts[name93].exists)
        }
        
    }
    
    func test_overwriteExistingFudaSet() {
        // given
        gotoPoemPickerScreen()
        let set2maiFudaName = "2枚札セット"
        add2maiFudaSetAsNewOne(app, setName: set2maiFudaName)
        let name1jiKimariSet = "一字決まり札セット"
        add1jiKimariFudaSetAsNewOne(app, setName: name1jiKimariSet)
        // when
        XCTContext.runActivity(named: "テストのために、わざと「1枚札セット」にもう１枚足してみる") { _ in
            app.cells["001"].tap()
        }
        app.navigationBars.buttons["保存"].tap()
        // then
        XCTContext.runActivity(named: "上書きする札セットを選ぶための、pickerWheel付きのAlert画面が表示される") { _ in
            let button = waitToHittable(for: app.sheets.buttons[overwriteExisingSetStr], timeout: timeOutSec)
            // when
            button.tap()
            // then
            waitToAppear(for: app.alerts.staticTexts["上書きする札セットを選ぶ"], timeout: timeOutSec)
            XCTAssert(app.alerts.pickerWheels.element.exists)
        }
        // when
        XCTContext.runActivity(named: "Alert上のPickerWheelで、一字決まり札セットを上書き対象として指示する") { _ in
            // when
            app.alerts.pickerWheels.element.adjust(toPickerWheelValue: name1jiKimariSet + " (7首)")
            app.alerts.buttons["上書きする"].tap()
            // then
            let button = waitToHittable(for: app.alerts.buttons["OK"], timeout: timeOutSec)
            XCTAssert(app.alerts.staticTexts["上書き完了"].exists)
            button.tap()
        }
        // then
        XCTContext.runActivity(named: "一字決まり札セットの枚数が8枚に上書きされている") { _ in
            // when
            gotoFudaSetsScreenFromPoemPicker()
            // then
            XCTAssert(app.cells.staticTexts["8首"].exists)
        }
    }
    
    private func allPoemsAreSelectedAtHomeScreen(_ app: XCUIApplication) {
        XCTAssert(app.cells.staticTexts["100首"].exists)
    }
    
    private func gotoFudaSetsScreenFromPoemPicker() {
        // when
        let buttonByGroup = waitToHittable(for: app.toolbars.buttons["まとめて選ぶ"], timeout: timeOutSec)
        buttonByGroup.tap()
        let buttonSavedSet = waitToHittable(for: app.sheets.buttons[selectBySetStr], timeout: timeOutSec)
        buttonSavedSet.tap()
        // then
        waitToAppear(for: app.navigationBars[selectBySetStr], timeout: timeOutSec)
    }
}

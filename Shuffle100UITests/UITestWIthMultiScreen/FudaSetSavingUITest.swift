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
        // when
        let pickerPage = homePage.goToPoemPickerPage()
        pickerPage.saveButton.tap()
        // then
        let sheet = SaveFudaSetActionSheet(app: app)
        XCTAssert(sheet.exists, "札セット保存の選択肢が表示される")
    }
    
    func test_saveNewFudaSet() {
        // given
        XCTAssert(homePage.numberOfSelecttedPoems(is: 100))
        // when
        let pickerPage = homePage.goToPoemPickerPage()
        pickerPage
            .tapCellOf_1_2_4()
            .saveCurrentPoemsAsSet(name: test97SetName)
            .selectAllButton.tap()  // 一旦百首選んだ状態にする
        pickerPage.backToTopPage()
        // then
        XCTAssert(homePage.exists)
        XCTAssert(homePage.numberOfSelecttedPoems(is: 100))
        // when
        homePage.goToPoemPickerPage()
        let fudaSetPage = pickerPage.gotoFudaSetPage()
        let test97Set = fudaSetPage.fudaSetCell(name: test97SetName)
        XCTAssert(test97Set.exists, "作ったばかりの札セットが登録されている")
        // when
        fudaSetPage
            .selectFudaSetCell(name: test97SetName)
            .backButton.tap()
        // then
        XCTAssert(pickerPage.exists)
        // when
        pickerPage.backToTopPage()
        // then
        XCTAssert(homePage.numberOfSelecttedPoems(is: 97))
    }
 
    func test_savingEmptyFudaSetIsInhibited() {
        // given
        let pickerPage = homePage.goToPoemPickerPage()
        // when
        pickerPage.cancelAllButton.tap()
        pickerPage.saveButton.tap()
        // then
        let alert = NoPoemToSaveAlert(app: app)
        XCTAssert(alert.exists, "選んだ歌がないまま札セット保存をしようとすると、アラート画面で警告")
        // when
        alert.dismissButton.tap()
        // then
        XCTAssertFalse(alert.exists, "アラート画面が消えている")
    }
    
    func test_emptyFudaSetNameIsInhibited() {
        // when
        let pickerPage = homePage.goToPoemPickerPage()
        pickerPage.saveButton.tap()
        // then
        let sheet = SaveFudaSetActionSheet(app: app)
        XCTAssert(sheet.exists)
        // when
        sheet.saveNewFudaSetButton.tap()
        // then
        let alertToNameSet = NameNewFudaSetAlert(app: app)
        XCTAssert(alertToNameSet.exists)
        // when
        alertToNameSet.confirmButton.tap()
        // then
        let noNameAlert = NoNameGivenForFudaSetAlert(app: app)
        XCTAssert(noNameAlert.exists, "札セットの名前が指定せず保存しようとすると、アラート画面で警告")
        // when
        noNameAlert.dismissButton.tap()
        // then
        XCTAssertFalse(noNameAlert.exists, "警告アラートは消える")
        XCTAssert(alertToNameSet.exists, "再び命名用のダイアログが現れる")
    }
    
    
    //
    // このテストを実行するときには、SimulatorのI/O -> Keyboardの中の
    // "Connet Hardware Keyboard"のチェックを外しておくこと！
    // そうしないと、動作不定になる。
    //
    func test_fudaSetCellDeletable() {
        let set97name = "97枚セット"
        let set2maiFudaName = "2枚札セット"
        
        // given
        let pickerPage = homePage.goToPoemPickerPage()
        // when
        pickerPage
            .add97FudaSetAsNewOne(setName: set97name)
            .add2maiFudaSetAsNewOne(setName: set2maiFudaName)
        let fudaSetPage = pickerPage.gotoFudaSetPage()
        // then
        XCTAssert(fudaSetPage.exists)
        XCTContext.runActivity(named: "札セットのセルを左にスワイプして削除ボタンをタップすると、そのセルが消える") { _ in
            // when
            fudaSetPage
                .swipeCellLeft(name: set97name)
                .delteButton.tap()
            // then
            XCTAssertFalse(fudaSetPage.fudaSetCell(name: set97name).exists)
            // when
            fudaSetPage
                .swipeCellLeft(name: set2maiFudaName)
                .delteButton.tap()
            // then
            XCTAssertFalse(fudaSetPage.fudaSetCell(name: set2maiFudaName).exists)
            // when
            fudaSetPage.backButton.tap()
            // then
            XCTAssert(pickerPage.exists)
        }
        XCTContext.runActivity(named: "その後、さらに札セットを新規追加しても、正しく動作する") { _ in
            let name93 = "一字決まり以外！"
            // when
            pickerPage
                .add93FudaSetAsNewOne(setName: name93)
                .gotoFudaSetPage()
            // then
            XCTAssert(fudaSetPage.exists)
            XCTAssert(fudaSetPage.fudaSetCell(name: name93).exists)
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
    
//    private func allPoemsAreSelectedAtHomeScreen(_ app: XCUIApplication) {
//        XCTAssert(app.cells.staticTexts["100首"].exists)
//    }
    
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

//
//  FudaSetSavingUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/05/20.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class FudaSetSavingUITest: XCTestCase {
  internal let app = XCUIApplication()
  private lazy var homePage = HomePage(app: app)
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
      .saveCurrentPoemsAsNewSet(name: test97SetName)
      .selectAllButton.tap()  // 一旦百首選んだ状態にする
    pickerPage.backToTopPage()
    // then
    XCTAssert(homePage.exists)
    XCTAssert(homePage.numberOfSelecttedPoems(is: 100))
    // when
    homePage.goToPoemPickerPage()
    let fudaSetPage = pickerPage.gotoFudaSetPage()
    let test97Set = fudaSetPage.fudaSet(with: test97SetName)
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
        .tapDeleteButton(for: set97name)
      // then
      XCTAssertFalse(fudaSetPage.fudaSet(with: set97name).exists)
      // when
      fudaSetPage
        .swipeCellLeft(name: set2maiFudaName)
        .tapDeleteButton(for: set2maiFudaName)
      // then
      XCTAssertFalse(fudaSetPage.fudaSet(with: set2maiFudaName).exists)
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
      XCTAssert(fudaSetPage.fudaSet(with: name93).exists)
    }
  }
  
  func test_overwriteExistingFudaSet() {
    let set2maiFudaName = "2枚札セット"
    let name1jiKimariSet = "一字決まり札セット"
    // given
    let pickerPage = homePage.goToPoemPickerPage()
    // when
    pickerPage
      .add2maiFudaSetAsNewOne(setName: set2maiFudaName)
      .add1jiKimariFudaSetAsNewOne(setName: name1jiKimariSet)
    // when
    XCTContext.runActivity(named: "テストのために、わざと「一時決まり札セット」にもう１枚足してみる") { _ in
      // when
      pickerPage
        .tapCellof(number: 1)
        .saveCurrentPoemsByOverwritingExistingSet(name: name1jiKimariSet + " (7首)")
      let fudaSetPage = pickerPage.gotoFudaSetPage()
      // then
      XCTAssert(fudaSetPage.exists)
      XCTAssert(fudaSetPage.numberOfSet(name: name1jiKimariSet, is: 8))
    }
  }
}

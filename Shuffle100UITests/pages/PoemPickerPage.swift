//
//  PoemPickerPage.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/04/05.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import Foundation
import XCTest

final class PoemPickerPage: PageObjectable, WaitInUITest {
  let app: XCUIApplication
  
  init(app: XCUIApplication) {
    self.app = app
  }
  
  var pageTitle: XCUIElement {
    app.navigationBars[A11y.title].firstMatch
  }
  
  var backToTopButton: XCUIElement {
    app.navigationBars.buttons[A11y.backToTop].firstMatch
  }
  
  var searchField: XCUIElement {
    app.searchFields[A11y.searchFieldPlaceHolder].firstMatch
  }
  
  var cancelSearchButton: XCUIElement {
    let cancelBtn = app.buttons[A11y.cancel].firstMatch // Before Liquid Glass UI
    let closeBtn = app.buttons[A11y.close].firstMatch   // Liquid Glass UI
//    app.buttons[A11y.cancel].firstMatch
    return closeBtn.exists ? closeBtn : cancelBtn
  }
  
  var cancelAllButton: XCUIElement {
    waitToHittable(for: app.buttons[A11y.cancelAll], timeout: timeOutSec)
  }
  
  var selectAllButton: XCUIElement {
//    waitToHittable(for: app.toolbars.buttons[A11y.selectAll], timeout: timeOutSec)
    waitToHittable(for: app.buttons[A11y.selectAll], timeout: timeOutSec)
  }
  
  var selectByGroupButton: XCUIElement {
//    waitToHittable(for: app.toolbars.buttons[A11y.selectByGroup].firstMatch, timeout: timeOutSec)
    waitToHittable(for: app.buttons[A11y.selectByGroup].firstMatch, timeout: timeOutSec)
  }
  
  var saveButton: XCUIElement {
    app.navigationBars.buttons[A11y.save].firstMatch
  }
  
  var firstCellInList: XCUIElement {
    app.cells.firstMatch
  }
  
  enum A11y {
    static let title = "歌を選ぶ"
    static let backToTop = "トップ"
    static let searchFieldPlaceHolder = "歌を検索"
    static let cancel = "キャンセル"
    static let cancelAll = "全て取消"
    static let selectAll = "全て選択"
    static let selectByGroup = "まとめて選ぶ"
    static let save = "保存"
    static let close = "閉じる"
  }
  
  func badge(of number: Int) -> XCUIElement {
    app.navigationBars.staticTexts["\(number)首"]
  }
  
  @discardableResult
  func tapCellof(number: Int) -> Self {
    cellOf(number: number).tap()
    return self
  }
  
  @discardableResult
  func tapDetailButtonOf(number: Int) -> TorifudaPage {
    app.buttons["detail_\(number)"].firstMatch.tap()
    return TorifudaPage(app: app)
  }
  
  @discardableResult
  func tapDetailButton(of cell: XCUIElement) -> TorifudaPage {
    cell.buttons.firstMatch.tap()
    return TorifudaPage(app: app)
  }
  
  @discardableResult
  func backToTopPage() -> HomePage {
    backToTopButton.tap()
    let homePage = HomePage(app: app)
    XCTAssert(homePage.exists, "トップ画面に戻った")
    return homePage
  }
  
  func cellOf(number: Int) -> XCUIElement {
//    app.otherElements.containing(.button, identifier: "detail_\(number)").firstMatch
    app.cells.containing(.button, identifier: "detail_\(number)").firstMatch
  }
  
  func longPress(number: Int) {
    cellOf(number: number).press(forDuration: 2.0)
  }
  
  @discardableResult
  func gotoNgramPickerPage() -> NgramPickerPage {
    let sheet = showSelectByGroupActionSheet()
    sheet.selectByNgramButton.tap()
    return NgramPickerPage(app: app)
  }
  
  @discardableResult
  func gotoDigitsPickerPage01() -> DigitsPickerPage01 {
    let sheet = showSelectByGroupActionSheet()
    sheet.selectByDigits01Button.tap()
    return DigitsPickerPage01(app: app)
  }
  
  @discardableResult
  func gotoDigitsPickerPage10() -> DigitsPickerPage10 {
    let sheet = showSelectByGroupActionSheet()
    sheet.selectByDigits10Button.tap()
    return DigitsPickerPage10(app: app)
  }
  
  func showSelectByGroupActionSheet() -> SelectByGroupActionSheet {
    selectByGroupButton.tap()
    return SelectByGroupActionSheet(app: app)
  }
  
  @discardableResult
  func saveCurrentPoemsAsNewSet(name: String) -> Self {
    // when
    saveButton.tap()
    let sheet = SaveFudaSetActionSheet(app: app)
    let button = waitToHittable(for: sheet.saveNewFudaSetButton, timeout: timeOutSec)
    button.tap()
    // then
    let alert = NameNewFudaSetAlert(app: app)
    XCTAssert(alert.exists, "新しい札セットを命名するダイアログが現れる")
    // when
    alert.textField.tap()
    alert.textField.typeText(name)
    alert.confirmButton.tap()
    // then
    let compAlert = SaveNewSetCompletedAlert(app: app)
    XCTAssert(compAlert.exists, "保存が完了した旨のダイアログが現れる")
    // when
    compAlert.confirmButton.tap()
    // then
    XCTAssertFalse(compAlert.exists, "確認ダイアログは消えている")
    // and
    return self
  }
  
  
}

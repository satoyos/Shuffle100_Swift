//
//  FudaSetPage.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/07/05.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import Foundation
import XCTest

final class FudaSetPage: PageObjectable {
  let app: XCUIApplication
  
  init(app: XCUIApplication) {
    self.app = app
  }
  
  var pageTitle: XCUIElement {
    app.navigationBars[A11y.title].firstMatch
  }
  
  var backButton: XCUIElement {
    app.buttons[A11y.back].firstMatch
  }
  
//  var delteButton: XCUIElement {
//    //        return app.tables.buttons[A11y.delete].firstMatch
//    //      app.tables.buttons[A11y.delete].firstMatch
//    app.staticTexts[A11y.delete].firstMatch
//  }
  
  enum A11y {
    static let title = "作った札セットから選ぶ"
    static let back = "歌を選ぶ" // 画面上の見かけと違うんだけど、どうしてだろう？ 2021/07/11
    static let delete = "削除"
  }
  
  func fudaSet(with text: String) -> XCUIElement {
    // SwiftUI版では、これ↓が一番いいみたい。
    app.staticTexts[text].firstMatch
  }
  
  func selectFudaSetCell(name: String) -> Self {
    // when
    let cell = fudaSet(with: name)
    // then
    XCTAssert(cell.exists)
    // and
    cell.tap()
    return self
  }
  
  @discardableResult
  func swipeCellLeft(name: String) -> Self {
    // when
    let cell = fudaSet(with: name)
    // then
    XCTAssert(cell.exists)
    
    cell.swipeLeft()
    return self
  }
  
  @discardableResult
  func tapDeleteButton(for fudaSetName: String) -> Self {
    let button = app.buttons["deleteFudaSet_\(fudaSetName)"]
    XCTAssert(button.waitForExistence(timeout: 3))
    button.tap()
    return self
  }
  
  func numberOfSet(name: String, is num: Int) -> Bool {
    app.otherElements
      .containing(.staticText, identifier: name)
      .containing(.staticText, identifier: "\(num)首")
      .firstMatch.exists
  }
}

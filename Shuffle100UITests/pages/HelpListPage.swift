//
//  HelpListPage.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/08/09.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import XCTest

final class HelpListPage: PageObjectable, WaitInUITest {
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var pageTitle: XCUIElement {
        return app.navigationBars[A11y.title].firstMatch
    }
    
    var evaluateAppCell: XCUIElement {
//        return app.tables.cells.staticTexts[A11y.evaluateApp].firstMatch
      app.staticTexts[A11y.evaluateApp].firstMatch
    }
    
    enum A11y {
        static let title = "ヘルプ"
        static let evaluateApp = "このアプリを評価する"
    }
    
    @discardableResult
    func canGotoDetailHelp(title: String) -> Self {
        // when
//        app.tables.staticTexts[title].tap()
      app.staticTexts[title].firstMatch.tap()
        // then
        XCTAssert(app.navigationBars[title].exists)
        // when
        let button = waitToHittable(for: app.navigationBars.buttons[A11y.title], timeout: timeOutSec * 3)
            // ↑ 初回のWebView読み込み時には結構時間がかかるため、しっかり時間をとる。
        button.tap()
        // then
        XCTAssert(self.exists, "ヘルプ一覧ページに戻る")
        // and
        return self
    }
  
  @discardableResult
  func scrollUp() -> Self {
    app.swipeUp()
    return self
  }
}

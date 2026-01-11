//
//  GotoRecitePoemScreenUITest.swift
//  Shuffle100UITests
//
//  Created by 里 佳史 on 2019/07/14.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

class GotoRecitePoemScreenUITest: XCTestCase {
    var app = XCUIApplication()
    lazy var homePage = HomePage(app: app)

    override func setUp() {
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }

  func test_RecitePoemScreenAppearWhenGameStartCellTapped() {
    // when
    let recitePage = homePage.gotoRecitePoemPage()
    // then
    XCTAssert(recitePage.exists)
    XCTAssert(recitePage.normalJokaDescLabel.exists)
  }
    
  func test_shortenJokaMode() {
    // when
    let settingsPage = homePage.gotoReciteSettingPage()
    // then
    XCTAssert(settingsPage.exists, "「いろいろな設定」ページに到達")
    let sjSwitch = waitToHittable(for: settingsPage.shortenJokaModeSwitch, timeout: timeOutSec)
    // when
    sjSwitch.tap()
    settingsPage.exitSettingsButton.tap()
    // then
    XCTAssert(homePage.exists)
    // when
    let recitePage = homePage.gotoRecitePoemPage()
    // then
    XCTAssert(recitePage.exists)
    XCTAssert(recitePage.shortJokaDescLabel.exists)
  }
  
    func test_backToHomeScreenUsingExitButton() {

        // given
        let recitePage = homePage.gotoRecitePoemPage()
        // when
        recitePage.exitGameButton.tap()
        // then
        let exitGameAlert = ExitGameDialog(app: app)
        XCTAssert(exitGameAlert.exists)
        // when
        let home = exitGameAlert.exitGameAndBackToTopPage()
        XCTAssert(home.exists)
    }
}

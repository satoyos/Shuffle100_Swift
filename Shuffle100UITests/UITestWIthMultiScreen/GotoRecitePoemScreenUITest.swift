//
//  GotoRecitePoemScreenUITest.swift
//  Shuffle100UITests
//
//  Created by 里 佳史 on 2019/07/14.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit
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
    
  func test_iPadRotationPreservesGameProgress() throws {
    try XCTSkipUnless(UIDevice.current.userInterfaceIdiom == .pad, "iPadの画面回転を検証する")
    let device = XCUIDevice.shared
    let originalOrientation = device.orientation
    defer { device.orientation = originalOrientation }
    device.orientation = .portrait
    assertAppOrientation(isLandscape: false)

    let recitePage = homePage.gotoRecitePoemPage()
    XCTAssertTrue(recitePage.jokaTitle.waitForExistence(timeout: timeOutSec))
    XCTAssertTrue(app.buttons[RecitePoemPage.A11y.pause].firstMatch.waitForExistence(timeout: timeOutSec))
    recitePage.tapForwardButton()
    XCTAssertTrue(recitePage.isReciting(number: 1, side: .kami))
    recitePage.tapForwardButton()
    XCTAssertTrue(recitePage.isReciting(number: 1, side: .shimo))
    recitePage.tapForwardButton()
    XCTAssertTrue(recitePage.isReciting(number: 2, side: .kami))

    // 通常モードで上の句を読み終えると、下の句への再生操作を待つ。
    let playButton = app.buttons[RecitePoemPage.A11y.play].firstMatch
    XCTAssertTrue(playButton.waitForExistence(timeout: timeOutSec))
    XCTAssertTrue(recitePage.isReciting(number: 2, side: .kami))

    for orientation in [UIDeviceOrientation.landscapeLeft, .portrait] {
      device.orientation = orientation
      assertAppOrientation(isLandscape: orientation.isLandscape)
      // 画面が作り直された場合、遅延して始まる序歌も検出する。
      XCTAssertFalse(recitePage.jokaTitle.waitForExistence(timeout: 2),
                     "回転後に序歌へ戻った: \(orientation)")
      XCTAssertTrue(recitePage.isReciting(number: 2, side: .kami))
      XCTAssertTrue(playButton.isHittable, "回転後も再生待ちを維持する")
    }

    playButton.tap()
    XCTAssertTrue(recitePage.isReciting(number: 2, side: .shimo))
  }

  private func assertAppOrientation(isLandscape: Bool, file: StaticString = #filePath, line: UInt = #line) {
    let rotated = NSPredicate { _, _ in
      let frame = self.app.frame
      return isLandscape ? frame.width > frame.height : frame.height > frame.width
    }
    let expectation = XCTNSPredicateExpectation(predicate: rotated, object: nil)
    XCTAssertEqual(XCTWaiter.wait(for: [expectation], timeout: timeOutSec), .completed,
                   "アプリの表示領域が指定した向きに変わる", file: file, line: line)
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

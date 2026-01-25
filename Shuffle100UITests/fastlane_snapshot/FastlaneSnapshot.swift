//
//  FastlaneSnapshot.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2022/10/23.
//  Copyright © 2022 里 佳史. All rights reserved.
//

import XCTest

@MainActor
final class FastlaneSnapshot: XCTestCase {
    let app = XCUIApplication()
    lazy var homePage = HomePage(app: app)

    override func setUpWithError() throws {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        setupSnapshot(app)
        app.launch()

        // 全テストをlandscapeで実行
        XCUIDevice.shared.orientation = .landscapeLeft
    }


//    func test_ScreenShotExample() throws {
//        // 「歌を選ぶ」画面に遷移した状態のスクリーンショットを撮ってみる
//        homePage.goToPoemPickerPage()
//        XCTAssert(PoemPickerPage(app: app).exists)
//        snapshot("0_trial_screenshot")
//    }
    func test_RecitePoemScreenShot() {
        // given
        let recitePage = homePage.gotoRecitePoemPage()
        // when
        recitePage.forwardButton.tap()
        // then
        XCTAssert(recitePage.isReciting(number: 1, side: .kami))
        // when
        sleep(2)
        recitePage.playButton.tap()
        // then
        XCTAssert(recitePage.isWaitinfForPlay)
        // take screenshot
        snapshot("1_RecitePoemScreen")
    }

    func test_IntervalScreenShot() {
        // when
        let settingsPage = homePage.gotoReciteSettingPage()
        // then
        XCTAssert(settingsPage.exists)
        // when
        settingsPage.intervalCell.tap()
        // then
        let intervalPage = IntervalSettingPage(app: app)
        XCTAssert(intervalPage.exists)
        // take screenshot
        snapshot("5_IntervalSettingScreen")
    }

    @MainActor
    func test_SearchScreenShot() {
        // when
        let pickerPage = homePage.goToPoemPickerPage()
        // then
        XCTAssert(pickerPage.exists)
        // when
        let searchField = pickerPage.searchField
        searchField.tap()
        searchField.typeText("春")
        // then
        XCTAssert(pickerPage.cellOf(number: 2).exists)
        XCTAssertFalse(pickerPage.cellOf(number: 1).exists)
        // take screenshot
        snapshot("3_SearchBar")
    }

    func test_PoemPickerScreenShot() {
        // when
        let pickerPage = homePage.goToPoemPickerPage()
        // then
        XCTAssert(pickerPage.exists)
        // when
        pickerPage.cancelAllButton.tap()
        pickerPage
            .tapCellof(number: 3)
            .tapCellof(number: 5)
            .tapCellof(number: 7)
        app.gentleSwipe(.Up, adjustment: 0.02)
        pickerPage
            .tapCellof(number: 8)
            .tapCellof(number: 11)
        // then
        XCTAssert(pickerPage.badge(of: 5).exists)
        // take screenshot
        snapshot("2_PickerScreen")
    }

    func test_5colorsScreenShot() {
        // when
        let pickerPage = homePage.goToPoemPickerPage()
        // then
        XCTAssert(pickerPage.exists)
        // when
        let fiveColorsPage = pickerPage.gotoFiveColorsPage()
        // then
        XCTAssert(fiveColorsPage.exists)
        // take screenshot
        snapshot("7_FiveColorsScreen")
    }
  
  func test_digitsPickerScreenShot() {
    // when
    let pickerPage = homePage.goToPoemPickerPage()
    // then
    XCTAssert(pickerPage.exists)
    // when
    let digitsPage01 = pickerPage.gotoDigitsPickerPage01()
    // then
    XCTAssert(digitsPage01.exists)
    // take screenshot
    snapshot("8_DigitsPicker01")
    // when
    digitsPage01.backToPickerButton.tap()
    // then
    XCTAssert(pickerPage.exists)
    // when
    let digitsPage10 = pickerPage.gotoDigitsPickerPage10()
    // then
    XCTAssert(digitsPage10.exists)
    // take screenshot
    snapshot("9_DigitsPicker10")
    
  }
  

    func test_TorifudaScreenShot() {
        // when
        let pickerPage = homePage.goToPoemPickerPage()
        // then
        XCTAssert(pickerPage.exists)
        // when
        let firstCell = pickerPage.cellOf(number: 1)
        pickerPage.tapDetailButton(of: firstCell)
        // then
        XCTAssert(TorifudaPage(app: app).exists)
        // take_screenshot
        snapshot("4_TorifudaScreen")
    }

    func test_MemorizeTimerScreenShot() {
        // when
        let timerPage = homePage.gotoMemorizeTimerPage()
        // then
        XCTAssert(timerPage.exists)
        // take screenshot
        snapshot("6_MemorizeTimerScreen")
    }
}

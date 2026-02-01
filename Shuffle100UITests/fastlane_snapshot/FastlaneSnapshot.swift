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
  
  enum FN { // stands for FileName
    static let recitePoemScreen =      "01_RecitePoemScreen"
    static let pickerScreen =          "02_PickerScreen"
    static let searchBar =             "03_SearchBar"
    static let torifudaScreen =        "04_TorifudaScreen"
    static let intervalSettingScreen = "05_IntervalSettingScreen"
    static let memorizeTimerScreen =   "06_MemorizeTimerScreen"
    static let fiveColorsScreen =      "07_FiveColorsScreen"
    static let digitsPicker01 =        "08_DigitsPicker01"
    static let digitsPicker10 =        "09_DigitsPicker10"
    static let whatsNextScreen =       "10_WhatsNextScreen"
    static let reciteSettingsScreen =  "11_ReciteSettingsScreen"
    static let volumeSettingScreen =   "12_VolumeSettingScreen"
    static let fudaSetsScreen =        "13_fudaSetsScreen"
    static let ngramPickerScreen =     "14_NgramPickerScreen"
    static let selectModeScreen =      "15_SelectModeScreen"
    static let selectSingerScreen =    "17_SelectSingerScreen"
  }

    override func setUpWithError() throws {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        setupSnapshot(app)
        app.launch()

        // 全テストをlandscapeで実行
        XCUIDevice.shared.orientation = .landscapeLeft
    }

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
        snapshot(FN.recitePoemScreen)
    }

    func test_IntervalScreenShot() {
        // when
        let settingsPage = homePage.gotoReciteSettingPage()
        // then
        XCTAssert(settingsPage.exists)
      // take screenshot
      snapshot("11_ReciteSettingsScreen")
        // when
        settingsPage.intervalCell.tap()
        // then
        let intervalPage = IntervalSettingPage(app: app)
        XCTAssert(intervalPage.exists)
        // take screenshot
        snapshot(FN.intervalSettingScreen)
    }

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
        snapshot(FN.searchBar)
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
        snapshot(FN.pickerScreen)
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
        snapshot(FN.fiveColorsScreen)
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
    snapshot(FN.digitsPicker01)
    // when
    digitsPage01.backToPickerButton.tap()
    // then
    XCTAssert(pickerPage.exists)
    // when
    let digitsPage10 = pickerPage.gotoDigitsPickerPage10()
    // then
    XCTAssert(digitsPage10.exists)
    // take screenshot
    snapshot(FN.digitsPicker10)
    
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
        snapshot("04_TorifudaScreen")
    }

    func test_MemorizeTimerScreenShot() {
        // when
        let timerPage = homePage.gotoMemorizeTimerPage()
        // then
        XCTAssert(timerPage.exists)
        // take screenshot
        snapshot(FN.memorizeTimerScreen)
    }
  
  func test_WhatsNextScreenShot() {
    // when
    let whatsNextPage = homePage.skipToWhatsNextPage(mode: .hokkaido)
    // then
    XCTAssert(whatsNextPage.exists)
    // take screenshot
    snapshot(FN.whatsNextScreen)
  }

  func test_VolumeSettingScreenShot() {
    // given, when
    let settingsPage = homePage.gotoReciteSettingPage()
    // then
    XCTAssert(settingsPage.fullVolumeLabel.exists)
    // when
    let volumePage = settingsPage.gotoVolumePage()
    // then
    XCTAssert(volumePage.exists, "音量調整のページに到達")
    // take screenshot
    snapshot(FN.volumeSettingScreen)
  }
  
  func test_fudaSetsScreenShot() {
    let set93name = "一字決まり以外"
    let set2maiFudaName = "2枚札セット"
        
    // when
    let pickerPage = homePage.goToPoemPickerPage()
    pickerPage
      .add93FudaSetAsNewOne(setName: set93name)
      .add2maiFudaSetAsNewOne(setName: set2maiFudaName)
    let fudaSetPage = pickerPage.gotoFudaSetPage()
    // then
    XCTAssert(fudaSetPage.exists)
    // take screenshots
    snapshot(FN.fudaSetsScreen)
  }
  
  func test_NgramPickerScreenShot() {
    // when
    let pickerPage = homePage.goToPoemPickerPage()
    // then
    XCTAssert(pickerPage.exists)
    // when
    let ngramPickerPage = pickerPage.gotoNgramPickerPage()
    // then
    XCTAssert(ngramPickerPage.exists)
    // take screenshot
    snapshot(FN.ngramPickerScreen)
  }
  
  func test_SelectModeScreenShot() {
    // when
    let selectModePage = homePage.gotoSelectModePage()
    // then
    XCTAssert(selectModePage.exists)
    // take screen shot
    snapshot(FN.selectModeScreen)
  }
  
  func test_SelectSingerScreenShot() {
    // when
    let selectSingerPage = homePage.gotoSelectSingerPage()
    // then
    XCTAssert(selectSingerPage.exists)
    // take screenshot
    snapshot(FN.selectSingerScreen)
  }
}

//
//  FastlaneSnapshot.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2022/10/23.
//  Copyright © 2022 里 佳史. All rights reserved.
//

import XCTest

final class FastlaneSnapshot: XCTestCase {
    let app = XCUIApplication()
    lazy var homePage = HomePage(app: app)

    override func setUpWithError() throws {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        setupSnapshot(app)
        app.launch()
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
        snapshot("5_IntervalSettingScreen")
    }
    
}

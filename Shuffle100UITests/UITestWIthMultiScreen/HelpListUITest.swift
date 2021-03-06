//
//  HelpListUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/06/22.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class HelpListUITest: XCTestCase {

    private var app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    func test_gotoHelpListScreen() throws {
       gotoHelpListScreen()
    }
    
    func test_showAllDetailHelp() {
        // given
        gotoHelpListScreen()
        // when, then
        canGotoDetailHelp(title: "設定できること")
        canGotoDetailHelp(title: "試合の流れ (通常モード)")
        canGotoDetailHelp(title: "「初心者モード」とは？")
        canGotoDetailHelp(title: "試合の流れ (初心者モード)")
        canGotoDetailHelp(title: "「ノンストップ・モード」とは？")
        canGotoDetailHelp(title: "「札セット」とその使い方")
        canGotoDetailHelp(title: "五色百人一首")
        canGotoDetailHelp(title: "暗記時間タイマー")
        canGotoDetailHelp(title: "「感想戦」のサポート")
        canGotoDetailHelp(title: "「いなばくん」について")
    }
    
    func test_openAppStoreReviewForm() {
        // given
        gotoHelpListScreen()
        // when
        app.tables.staticTexts["このアプリを評価する"].tap()
        // then
        _ = waitToHittable(for: app.alerts.buttons["立ち上げる"], timeout: timeOutSec)
    }

    private func gotoHelpListScreen() {
        // when
        app.buttons["HelpButton"].tap()
        // then
        XCTAssert(app.navigationBars["ヘルプ"].exists)
    }
    
    private func canGotoDetailHelp(title: String) {
        // when
        app.tables.staticTexts[title].tap()
        // then
        XCTAssert(app.navigationBars[title].exists)
        // when
        let button = waitToHittable(for: app.navigationBars.buttons["ヘルプ"], timeout: timeOutSec * 3)
            // ↑ 初回のWebView読み込み時には結構時間がかかるため、しっかり時間をとる。
        button.tap()
        // then
        XCTAssert(app.navigationBars["ヘルプ"].exists)
    }
}

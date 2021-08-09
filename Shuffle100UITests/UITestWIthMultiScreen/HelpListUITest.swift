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
    lazy private var homePage = HomePage(app: app)

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    func test_gotoHelpListScreen() {
        // when
        let helpListPage = homePage.gotoHelpListPage()
        // then
        XCTAssert(helpListPage.exists, "ヘルプ(一覧)ページに到達")
    }
    
    func test_showAllDetailHelp() {
        // given
        let helpListPage = homePage.gotoHelpListPage()
        // when, then
        helpListPage
            .canGotoDetailHelp(title: "設定できること")
            .canGotoDetailHelp(title: "試合の流れ (通常モード)")
            .canGotoDetailHelp(title: "「初心者モード」とは？")
            .canGotoDetailHelp(title: "試合の流れ (初心者モード)")
            .canGotoDetailHelp(title: "「ノンストップ・モード」とは？")
            .canGotoDetailHelp(title: "「札セット」とその使い方")
            .canGotoDetailHelp(title: "五色百人一首")
            .canGotoDetailHelp(title: "暗記時間タイマー")
            .canGotoDetailHelp(title: "「感想戦」のサポート")
            .canGotoDetailHelp(title: "「いなばくん」について")
    }
    
    func test_openAppStoreReviewForm() {
        // given
        let helpListPage = homePage.gotoHelpListPage()
        // when
        helpListPage.evaluateAppCell.tap()
        // then
        let evalAppDialog = EvaluateAppDialog(app: app)
        XCTAssert(evalAppDialog.exists, "App Storeに移動していいかどうかを確認するダイアログが表示される")
    }
}

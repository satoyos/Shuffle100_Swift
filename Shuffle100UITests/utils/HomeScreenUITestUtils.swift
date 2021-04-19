//
//  HomeScreenUITestUtils.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/01/08.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

protocol HomeScreenUITestUtils {
    var app: XCUIApplication { get }
    var homePage: HomePage { get }
    func gotoPoemPickerScreen()
    func gotoRecitePoemScreen()
    func gotoReciteSettingsScreen(_ app: XCUIApplication) -> Void
}

extension HomeScreenUITestUtils {
    
    var homePage: HomePage {
        return HomePage(app: app)
    }
    
    func gotoPoemPickerScreen() {
        XCTAssert(homePage.goToPoemPickerPage().exists, "「歌を選ぶ」ページに到達。")
    }
    
    func gotoRecitePoemScreen() -> Void {
        let page = homePage.gotoRecitePoemPage()
        XCTAssert(page.exists, "読み上げページに到達。")
        XCTAssert(page.jokaTitle.exists, "タイトルが「序歌」である")
    }
    
    @discardableResult
    func gotoSelectModeScreen() -> SelectModePage {
        let selectModePage = homePage.gotoSelectModePage()
        XCTAssert(selectModePage.exists, "「読み上げモードを選ぶ」画面に到達")
        return selectModePage
    }
    
    @discardableResult
    func gotoSelectSingerScreen() -> SelectSingerPage {
        let selectSingerPage = homePage.gotoSelectSingerPage()

        XCTAssert(selectSingerPage.exists, "「毒手を選ぶ」画面に到達")
        return selectSingerPage
    }
    
    func gotoReciteSettingsScreen(_ app: XCUIApplication) {
        // when
        app.navigationBars["トップ"].buttons["GearButton"].tap()
        // then
        XCTAssert(app.navigationBars["いろいろな設定"].exists)
    }
}

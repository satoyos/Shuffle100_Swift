//
//  HomeScreenUITestUtils.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/01/08.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

protocol HomeScreenUITestUtils {
    func gotoPoemPickerScreen(_ app: XCUIApplication) -> Void
    func gotoRecitePoemScreen(_ app: XCUIApplication) -> Void
}

extension HomeScreenUITestUtils {
    func gotoPoemPickerScreen(_ app: XCUIApplication) {
        // when
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["取り札を用意する歌"]/*[[".cells[\"poemsCell\"].staticTexts[\"取り札を用意する歌\"]",".staticTexts[\"取り札を用意する歌\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        // then
        XCTAssert(app.navigationBars["歌を選ぶ"].exists)
    }
    
    func gotoRecitePoemScreen(_ app: XCUIApplication) -> Void {
        // when
        app.tables.cells["GameStartCell"].tap()
        // then
        XCTAssert(app.staticTexts["序歌"].exists)
    }
    
    
    
    func gotoSelectModeScreen(_ app: XCUIApplication) {
        // when
        app.tables.staticTexts["読み上げモード"].tap()
        // then
        XCTAssert(app.navigationBars["読み上げモードを選ぶ"].exists)
    }
    

    
    func gotoSelectSingerScreen(_ app: XCUIApplication) {
        // when
        app.tables.staticTexts["読手"].tap()
        // then
        XCTAssert(app.navigationBars["読手を選ぶ"].exists)
    }
    
}

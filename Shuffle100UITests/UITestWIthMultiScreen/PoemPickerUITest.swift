//
//  PoemPickerUITest.swift
//  Shuffle100UITests
//
//  Created by 里 佳史 on 2019/05/06.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

class PoemPickerUITest: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_HomeScreenReflectsSelectioninPoemPicker() {
        // given
        let tablesQuery = app.tables
        XCTAssertTrue(app.cells.staticTexts["100首"].exists)
        // when
        //   goes to PocmPickerScreen
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["取り札を用意する歌"]/*[[".cells[\"poemsCell\"].staticTexts[\"取り札を用意する歌\"]",".staticTexts[\"取り札を用意する歌\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        //   tap poems #1,3,5
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["1. 秋の田の かりほの庵の とまをあらみ 我が衣手は 露にぬれつつ"]/*[[".cells.staticTexts[\"1. 秋の田の かりほの庵の とまをあらみ 我が衣手は 露にぬれつつ\"]",".staticTexts[\"1. 秋の田の かりほの庵の とまをあらみ 我が衣手は 露にぬれつつ\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["3. あしびきの 山鳥の尾の しだり尾の ながながし夜を ひとりかもねむ"]/*[[".cells.staticTexts[\"3. あしびきの 山鳥の尾の しだり尾の ながながし夜を ひとりかもねむ\"]",".staticTexts[\"3. あしびきの 山鳥の尾の しだり尾の ながながし夜を ひとりかもねむ\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["5. 奥山に 紅葉踏み分け 鳴く鹿の 声聞くときぞ 秋はかなしき"]/*[[".cells.staticTexts[\"5. 奥山に 紅葉踏み分け 鳴く鹿の 声聞くときぞ 秋はかなしき\"]",".staticTexts[\"5. 奥山に 紅葉踏み分け 鳴く鹿の 声聞くときぞ 秋はかなしき\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["歌を選ぶ"].buttons["トップ"].tap()
        // then
        XCTAssertTrue(app.cells.staticTexts["97首"].exists)
    }
}


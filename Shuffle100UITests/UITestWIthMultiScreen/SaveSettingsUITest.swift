//
//  SaveSettingsUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/02/19.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class SaveSettingsUITest: XCTestCase, SetEnvUITestUtils, HomeScreenUITestUtils {
    

    func test_savedDataAffectsLaterGames() {
        let app = XCUIApplication()

        XCTContext.runActivity(named: "まずはデフォルト状態でアプリを起動する") { (acitivity) in
            // given
            // when
            setEnvIgnoreSavedData(app)
            app.launch()
            // then
            XCTAssert(app.staticTexts["100首"].exists)
        }
//        XCTContext.runActivity(named: "テスト状態でなくし、歌を2首選択を外して、トップに戻ってから、アプリを落とす") { (acitivity) in
//            setEnv(app)
//            gotoPoemPickerScreen(app)
//            XCTAssert(app.searchFields["歌を検索"].exists)
//            app.tables.cells["001"].tap()
//            app.tables.cells["003"].tap()
//            app.navigationBars["歌を選ぶ"].buttons["トップ"].tap()
//            XCTAssert(app.staticTexts["98首"].exists)
//            app.terminate()
//        }
    }


}

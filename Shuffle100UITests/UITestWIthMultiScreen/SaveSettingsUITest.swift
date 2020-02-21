//
//  SaveSettingsUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/02/19.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class SaveSettingsUITest: XCTestCase, SetEnvUITestUtils, HomeScreenUITestUtils, PoemPickerScreenUITestUtils {
    

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
        XCTContext.runActivity(named: "データのセーブとロードを有効にし、歌を2首選択を外して、トップに戻ってから、アプリを落とす") { (acitivity) in
            // given
            setEnvLoadSavedData(app)
            setEnvWillSaveData(app)
            gotoPoemPickerScreen(app)
            app.tables.cells["001"].tap()
            app.tables.cells["003"].tap()
            goBackToHomeScreen(app)
            XCTAssert(app.staticTexts["98首"].exists)
            // when
            app.terminate()
            // then
            XCTAssertFalse(app.staticTexts["98首"].exists)
        }
        XCTContext.runActivity(named: "再度アプリを起動すると、落とす前に選択していたデータが再現されている") { (acitivity) in
            // when

            app.activate()
            // then
            XCTAssert(app.staticTexts["98首"].exists)
        }
    }


}

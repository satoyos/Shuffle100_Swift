//
//  AllPeomRecitedUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/01/04.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class AllPeomRecitedUITest: XCTestCase, HomeScreenUITestUtils, RecitePoemScreenUITestUtils {

   let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_GameEndViewAppears() {
        XCTContext.runActivity(named: "第1首のみ選択している状態にする。") { (activity) in
            // given
            gotoPoemPickerScreen(app)
            sleep(1)
            // when
            app.buttons["全て取消"].tap()
            app.tables.cells["001"].tap()
            app.navigationBars["歌を選ぶ"].buttons["トップ"].tap()
            // then
            XCTAssertTrue(app.cells.staticTexts["1首"].exists)
        }
        XCTContext.runActivity(named: "試合を開始し、forward -> forward -> playで第1首の下の句の読み上げを開始する") { (activity) in
            // given
            gotoRecitePoemScreen(app)
            // when
            tapForwardButton(app)
            sleep(1)
            tapForwardButton(app)
            sleep(1)
            tapPlayButton(app)
            sleep(1)
            // then
            XCTAssert(app.staticTexts["1首め:下の句 (全1首)"].exists)
        }
        XCTContext.runActivity(named: "最後の歌を読み終えると、「試合終了」画面が現れる") { (activity) in
            // when
            tapForwardButton(app)
            sleep(1)
            XCTAssert(app.staticTexts["試合終了"].exists)
        }
        XCTContext.runActivity(named: "「トップに戻る」ボタンを押すと、トップ画面に戻る") { (activity) in
            // when
            app.buttons["トップに戻る"].tap()
            sleep(1)
            XCTAssert(app.navigationBars["トップ"].exists)
        }
    }
}

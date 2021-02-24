//
//  PostMortemUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/02/23.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import XCTest

class PostMortemUITest: XCTestCase, HomeScreenUITestUtils, RecitePoemScreenUITestUtils {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_postMotermFromGameEndView() throws {
        XCTContext.runActivity(named: "まず、「いろいろな設定」画面で感想戦モードを有効にする") { _ in
            // when
            gotoReciteSettingsScreen(app)
            app.switches["modeSwitch"].tap()
            app.navigationBars.buttons["設定終了"].tap()
            // then
            XCTAssert(app.navigationBars["トップ"].exists)
        }
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
//            XCTContext.runActivity(named: "その画面には、「トップに戻る」ボタンと「感想戦を始める」ボタンがある") { _ in
//                
//            }
        }
//        XCTContext.runActivity(named: "感想戦モードが有効な状態で「試合終了」を選択すると、その後どうするかをユーザに問うActionSheetが現れる") { _ in
//            // when
//            app.buttons["試合を終える"].tap()
//            // then
//            XCTAssert(app.sheets.element.exists)
//        }
    }

}

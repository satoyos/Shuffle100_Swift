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
        activatePostMortemMode()
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
        XCTContext.runActivity(named: "空札を有効にする") { _ in
            app.switches["modeSwitch"].tap()
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
            // then
            waitToAppear(for: app.staticTexts["1首め:下の句 (全2首)"], timeout: timeOutSec)
        }
        XCTContext.runActivity(named: "2首めに入り、どんどん飛ばす") { _ in
            // when
            tapForwardButton(app)
            sleep(1)
            tapForwardButton(app)
            sleep(1)
            tapPlayButton(app)
            // then
            waitToAppear(for: app.staticTexts["2首め:下の句 (全2首)"], timeout: timeOutSec)
        }
        
        gameEndViewWithPostMortemButtonAppars()
        
        XCTContext.runActivity(named: "「感想戦を始める」ボタンを押すと、本当に始めるかどうか聞くアラートが現れる") { _ in
            // when
            app.buttons["感想戦を始める"].tap()
            // then
            XCTAssert(app.alerts.element.exists)
        }
        XCTContext.runActivity(named: "アラートで「始める」をタップすると、実際に感想戦が始まる") { _ in
            // when
            app.alerts.buttons["始める"].tap()
            // then
            waitToAppear(for: app.staticTexts["序歌"], timeout: timeOutSec * 2)
        }
        XCTContext.runActivity(named: "1首め, 2首めとまた進む") { _ in
            // when
            tapForwardButton(app)
            sleep(1)
            tapForwardButton(app)
            sleep(1)
            tapPlayButton(app)
            // then
            waitToAppear(for: app.staticTexts["1首め:下の句 (全2首)"], timeout: timeOutSec)
            // when
            tapForwardButton(app)
            sleep(1)
            tapForwardButton(app)
            sleep(1)
            tapPlayButton(app)
            // then
            waitToAppear(for: app.staticTexts["2首め:下の句 (全2首)"], timeout: timeOutSec)
        }
        gameEndViewWithPostMortemButtonAppars()
    }
    
    func test_startpostMortemFromExitButton() {
        activatePostMortemMode()
        XCTContext.runActivity(named: "試合を開始し、forward -> forward -> playで第1首の下の句の読み上げを開始する") { (activity) in
            // given
            gotoRecitePoemScreen(app)
            // when
            tapForwardButton(app)
            sleep(1)
            tapForwardButton(app)
            sleep(1)
            tapPlayButton(app)
            // then
            waitToAppear(for: app.staticTexts["1首め:下の句 (全100首)"], timeout: timeOutSec)
        }
        XCTContext.runActivity(named: "2首めに入り、どんどん飛ばす") { _ in
            // when
            tapForwardButton(app)
            sleep(1)
            tapForwardButton(app)
            sleep(1)
            tapPlayButton(app)
            // then
            waitToAppear(for: app.staticTexts["2首め:下の句 (全100首)"], timeout: timeOutSec)
        }
        XCTContext.runActivity(named: "Exitボタンを押すと、感想戦も選択肢に入ったActionSheetが現れる") { _ in
            // when
            app.buttons["exit"].tap()
            // then
            XCTAssertFalse(app.alerts.element.exists)
            _ =  waitToHittable(for: app.sheets.buttons["感想戦を始める"], timeout: timeOutSec)
        }
        XCTContext.runActivity(named: "「感想戦を始める」を選ぶと、実際に始まる") { _ in
            // when
            app.sheets.buttons["感想戦を始める"].tap()
            // then
            waitToAppear(for: app.staticTexts["序歌"], timeout: timeOutSec * 2)
        }
    }
    
    private func activatePostMortemMode() {
        XCTContext.runActivity(named: "まず、「いろいろな設定」画面で感想戦モードを有効にする") { _ in
            // when
            gotoReciteSettingsScreen(app)
            app.switches["modeSwitch"].tap()
            app.navigationBars.buttons["設定終了"].tap()
            // then
            XCTAssert(app.navigationBars["トップ"].exists)
        }
    }
    
    private func gameEndViewWithPostMortemButtonAppars() {
        XCTContext.runActivity(named: "最後の歌を読み終えると、「試合終了」画面が現れる") { (activity) in
            // when
            tapForwardButton(app)
            sleep(1)
            XCTAssert(app.staticTexts["試合終了"].exists)
            XCTContext.runActivity(named: "その画面には、「トップに戻る」ボタンと「感想戦を始める」ボタンがある") { _ in
                XCTAssert(app.buttons["トップに戻る"].exists)
                XCTAssert(app.buttons["感想戦を始める"].exists)
            }
        }
    }

}

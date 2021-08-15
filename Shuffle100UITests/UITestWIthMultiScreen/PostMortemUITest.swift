//
//  PostMortemUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/02/23.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import XCTest

class PostMortemUITest: XCTestCase, HomeScreenUITestUtils, RecitePoemScreenUITestUtils {
    
    internal let app = XCUIApplication()
    internal lazy var homePage = HomePage(app: app)

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
        // given
        activatePostMortemMode()
        selectJustNo1Poem()
        homePage.fakeModeSwitch.tap() // 空札を有効にする
        let recitePage = homePage.gotoRecitePoemPage()
        let endPage = AllPoemRecitedPage(app: app)
        // when
        XCTContext.runActivity(named: "試合を開始し、第1首の下の句の読み上げまで進める") { _  in
            // when
            recitePage
                .tapForwardButton()
                .tapForwardButton()
                .playButton.tap()
            // then
            XCTAssert(recitePage.isReciting(number: 1, side: .shimo, total: 2))
        }
        XCTContext.runActivity(named: "2首めに入り、どんどん飛ばす") { _ in
            // when
            recitePage
                .tapForwardButton()
                .tapForwardButton()
                .playButton.tap()
            // then
            XCTAssert(recitePage.isReciting(number: 2, side: .shimo, total: 2))
        }
        // when
        recitePage.tapForwardButton()
        // then
        XCTAssert(endPage.exists, "「試合終了」画面が現れる")
        // when
        endPage.postMortemButton.tap()
        // then
        let dialog = ConfirmPostMortemDialog(app: app)
        XCTAssert(dialog.exists, "感想戦を始めるかどうか確認するダイアログが現れる")
        // when
        dialog.confirmButton.tap()
        // then
        XCTAssert(recitePage.isRecitingJoka)
        
        XCTContext.runActivity(named: "1首め, 2首めとまた進む") { _ in
            // when
            recitePage
                .tapForwardButton()
                .tapForwardButton()
                .playButton.tap()
            // then
            XCTAssert(recitePage.isReciting(number: 1, side: .shimo, total: 2))
            // when
            recitePage
                .tapForwardButton()
                .tapForwardButton()
                .playButton.tap()
            // then
            XCTAssert(recitePage.isReciting(number: 2, side: .shimo, total: 2))
        }
        // when
        recitePage.tapForwardButton()
        // then
        XCTAssert(endPage.exists)
        
        XCTContext.runActivity(named: "この画面で「トップに戻る」ボタンを押すと、そのとおりに画面遷移する。") { _ in
            // when
            endPage.backToTopButton.tap()
            // then
            XCTAssert(homePage.exists)
        }
    }
    
    func test_startpostMortemFromExitButton() {
        // given
        activatePostMortemMode()
        // when
        let recitePage = homePage.gotoRecitePoemPage()
        recitePage
            .tapForwardButton()
            .tapForwardButton()
            .playButton.tap()
        // then
        XCTAssert(recitePage.isReciting(number: 1, side: .shimo))
        // when
        recitePage
            .tapForwardButton()
            .tapForwardButton()
            .playButton.tap()
        // then
        XCTAssert(recitePage.isReciting(number: 2, side: .shimo))
        // when
        recitePage.exitGameButton.tap()
        // then
        let sheet = ExitGameActionSheet(app: app)
        XCTAssert(sheet.exists)
        XCTAssert(sheet.postMortemAButton.exists)
        // when
        sheet.postMortemAButton.tap()
        // then
        XCTAssert(recitePage.isRecitingJoka, "実際に感想戦が始まる")
    }
    
    func test_backToHomeViaExitButtonInPostMortemMode() {
        activatePostMortemMode()
        XCTContext.runActivity(named: "試合を開始し、forward -> forward -> playで第1首の下の句の読み上げを開始する") { (activity) in
            // given
            gotoRecitePoemScreen()
            // when
            tapForwardButton(app)
            sleep(1)
            tapForwardButton(app)
            sleep(1)
            tapPlayButton(app)
            // then
            waitToAppear(for: app.staticTexts["1首め:下の句 (全100首)"], timeout: timeOutSec)
        }
        XCTContext.runActivity(named: "Exitボタンを押して現れるActionSheetで「トップに戻る」を選ぶと、その通りに画面遷移する") { _ in
            // when
            app.buttons["exit"].tap()
            let backToHomeButton = waitToHittable(for: app.sheets.buttons["トップに戻る"], timeout: timeOutSec)
            backToHomeButton.tap()
            // then
            waitToAppear(for: app.navigationBars.staticTexts["トップ"], timeout: timeOutSec)
        }
    }
    
    func test_changePostMortemModeDuringGame() {
        // given
        gotoRecitePoemScreen()
        XCTContext.runActivity(named: "デフォルトの状態では、Exitボタンを押すと通常のアラート画面が表示される") { _ in
            app.buttons["exit"].tap()
            // then
            let continueButton = waitToHittable(for: app.alerts.buttons["続ける"], timeout: timeOutSec)
            // when
            continueButton.tap()
        }
        XCTContext.runActivity(named: "「いろいろな設定」画面で感想戦を選べるように設定変更する") { _ in
            // when
            let gearButton = waitToHittable(for: app.buttons["gear"], timeout: timeOutSec)
            gearButton.tap()
            // then
            XCTAssert(app.navigationBars.staticTexts["いろいろな設定"].exists)
            // when
            sleep(1)
            app.switches["postMortemModeSwitch"].tap()
            app.buttons["設定終了"].tap()
            // then
            XCTAssert(app.staticTexts["序歌"].exists)
        }
        XCTContext.runActivity(named: "1種目の下の句まで進める") { _ in
            tapPlayButton(app)
            tapForwardButton(app)
            sleep(1)
            tapForwardButton(app)
            sleep(1)
            tapPlayButton(app)
            // then
            waitToAppear(for: app.staticTexts["1首め:下の句 (全100首)"], timeout: timeOutSec)
        }
        XCTContext.runActivity(named: "次にExitボタンを押すと、今度は「感想戦を始める」を選べる") { _ in
            // when
            app.buttons["exit"].tap()
            // then
            let postMortemButton = waitToHittable(for: app.sheets.buttons["感想戦を始める"], timeout: timeOutSec)
            // when
            postMortemButton.tap()
            // then
            waitToAppear(for: app.staticTexts["序歌"], timeout: timeOutSec)
        }
    }
    
    private func activatePostMortemMode() {
        // when
        let settingsPage = homePage.gotoReciteSettingPage()
        // then
        XCTAssert(settingsPage.exists)
        // when
        settingsPage
            .switchPostMortemMode()
            .exitSettingsButton.tap()
        // then
        XCTAssert(homePage.exists, "トップページに戻る")
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
    
    private func selectJustNo1Poem() {
        XCTContext.runActivity(named: "第1首のみ選択している状態にする。") {_ in
            // when
            let pickerPage = homePage.goToPoemPickerPage()
            // then
            XCTAssert(pickerPage.exists)
            // when
            pickerPage.cancelAllButton.tap()
            pickerPage
                .tapCellof(number: 1)
                .backToTopPage()
            // then
            XCTAssert(homePage.exists)
            XCTAssert(homePage.numberOfSelecttedPoems(is: 1))
            
//            // given
//            gotoPoemPickerScreen()
//            sleep(1)
//            // when
//            app.buttons["全て取消"].tap()
//            app.tables.cells["001"].tap()
//            app.navigationBars["歌を選ぶ"].buttons["トップ"].tap()
//            // then
//            XCTAssertTrue(app.cells.staticTexts["1首"].exists)
        }
    }

}

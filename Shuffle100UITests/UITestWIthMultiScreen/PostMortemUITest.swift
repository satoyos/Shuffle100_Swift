//
//  PostMortemUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2021/02/23.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import XCTest

class PostMortemUITest: XCTestCase {
    
    internal let app = XCUIApplication()
    internal lazy var homePage = HomePage(app: app)

    override func setUpWithError() throws {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
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
        recitePage.exitGameButton.tap()
        // then
        let sheet = ExitGameActionSheet(app: app)
        XCTAssert(sheet.exists)
        // when
        sheet.backToTopButton.tap()
        // then
        XCTAssert(homePage.exists, "指示通りにトップページに戻る")
    }
    
    func test_changePostMortemModeDuringGame() {
        // when
        let recitePage = homePage.gotoRecitePoemPage()
        recitePage.exitGameButton.tap()
        // then
        let alert = ExitGameDialog(app: app)
        XCTAssert(alert.exists, "デフォルトの状態では、Exitボタンを押すと通常のアラート画面が表示される")
        // when
        alert.cancelButton.tap()
        // then
        XCTAssertFalse(alert.exists)
        // when
        recitePage.gearButton.tap()
        // then
        let settingsPage = ReciteSettingsPage(app: app)
        XCTAssert(settingsPage.exists, "「いろいろな設定」画面が現れる")
        // when
        settingsPage
            .switchPostMortemMode()
            .exitSettingsButton.tap()
        // then
        XCTAssert(recitePage.isRecitingJoka)
        // when
        recitePage.playButton.tap()
        recitePage
            .tapForwardButton()
            .tapForwardButton()
            .playButton.tap()
        // then
        XCTAssert(recitePage.isReciting(number: 1, side: .shimo))
        // when
        recitePage.exitGameButton.tap()
        // then
        let sheet = ExitGameActionSheet(app: app)
        XCTAssert(sheet.exists, "次にExitボタンを押すと、今度は「感想戦を始める」を選べる")
        // when
        sheet.postMortemAButton.tap()
        // then
        XCTAssert(recitePage.isRecitingJoka)
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
        }
    }
}

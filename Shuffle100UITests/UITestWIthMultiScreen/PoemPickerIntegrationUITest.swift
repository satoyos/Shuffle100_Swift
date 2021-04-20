//
//  PoemPickerUITest.swift
//  Shuffle100UITests
//
//  Created by 里 佳史 on 2019/05/06.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

//class PoemPickerIntegrationUITest: XCTestCase, HomeScreenUITestUtils, PoemPickerScreenUITestUtils {
class PoemPickerIntegrationUITest: XCTestCase, PoemPickerScreenUITestUtils {

    var app = XCUIApplication()
    lazy var homePage = HomePage(app: app)
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
        self.homePage = HomePage(app: app)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func test_HomeScreenReflectsSelectioninPoemPicker() {
        
        XCTContext.runActivity(named: "デフォルトのトップ画面に「100首」と書かれたセルが存在する") { (activity) in
            XCTAssert(homePage.numberOfSelecttedPoems(is: 100))
        }
        let poemPickerPage = homePage.goToPoemPickerPage()
        XCTAssert(poemPickerPage.exists, "「歌を選ぶ」画面に到達")
        XCTContext.runActivity(named: "プレースホルダ付きの検索窓がある") { (activity) in
            XCTAssert(app.searchFields["歌を検索"].exists)
        }
        XCTContext.runActivity(named: "歌を3つタップして選択状態を解除し、トップ画面に戻ると、歌の数が97首になっている") { (activity) in
            //   tap poems #1,2, 4
            poemPickerPage
                .tapCellof(number: 1)
                .tapCellof(number: 2)
                .tapCellof(number: 4)
                .backToTopPage()
            // then
            XCTAssert(homePage.numberOfSelecttedPoems(is: 97))
        }
    }
    
    func test_searchPoem() {
        // given
//        gotoPoemPickerScreen(app)
        XCTAssert(homePage.goToPoemPickerPage().exists)
        XCTContext.runActivity(named: "検索窓に「あき」を入力すると、検索用データがそれにヒットする歌のみ表示される"){
            (activity) in
            // when
            let searchField = app.searchFields.element
            searchField.tap()
            searchField.typeText("あき")
            // then
            XCTAssert(app.tables.cells["001"].exists)
            XCTAssertFalse(app.tables.cells["002"].exists)
            XCTAssert(app.tables.cells["005"].exists)
        }
        XCTContext.runActivity(named: "検索結果としてフィルタリングされた歌をタップしたら、選択状態を変えることができる") { (acitvity) in
            // when
            app.tables.cells["001"].tap()
            app.tables.cells["005"].tap()
            app.buttons["キャンセル"].tap()
            //   back to HomeScreen
            goBackToHomeScreen(app)
            // then
            XCTAssertTrue(app.cells.staticTexts["98首"].exists)
        }
    }
    
    func test_alertAppearsWhenStartGameWithoutSelectedPoem() {
        // given
//        gotoPoemPickerScreen(app)
        XCTAssert(homePage.goToPoemPickerPage().exists, "「歌を選ぶ」画面に到達")
        let button = waitToHittable(for: app.buttons["全て取消"], timeout: timeOutSec)
        button.tap()
        goBackToHomeScreen(app)
        XCTAssert(app.staticTexts["0首"].exists)
        XCTContext.runActivity(named: "歌を全く選ばないまま試合を開始しようとすると、アラートが表示される") { activity in
            // when
            app.cells["GameStartCell"].tap()
            // then
            XCTAssert(app.staticTexts["詩を選びましょう"].exists)
        }
        XCTContext.runActivity(named: "アラート画面で「戻る」ボタンを押すと、アラートは消える") { acivity in
            // when
            app.buttons["戻る"].tap()
            // then
            XCTAssertFalse(app.staticTexts["詩を選びましょう"].exists)
        }
        XCTContext.runActivity(named: "アラート画面が消えてトップ画面に戻ったとき、「試合開始」セルの選択は解除された状態になっている") { activity in
            XCTAssertFalse(app.cells["GameStartCell"].isSelected)
        }
    }
}


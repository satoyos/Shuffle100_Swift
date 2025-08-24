//
//  PoemPickerUITest.swift
//  Shuffle100UITests
//
//  Created by 里 佳史 on 2019/05/06.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

final class PoemPickerIntegrationUITest: XCTestCase {
  
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
    XCTAssert(poemPickerPage.searchField.exists, "プレースホルダ付きの検索窓がある")
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
    // when
    let poemPickerPage = homePage.goToPoemPickerPage()
    
    XCTContext.runActivity(named: "検索窓に「あき」を入力すると、検索用データがそれにヒットする歌のみ表示される"){
      _ in
      // when
      let searchField = poemPickerPage.searchField
      searchField.tap()
      searchField.typeText("あき")
      // then
      XCTAssert(poemPickerPage.cellOf(number: 1).exists)
      XCTAssertFalse(poemPickerPage.cellOf(number: 2).exists)
      XCTAssert(poemPickerPage.cellOf(number: 5).exists)
    }
    XCTContext.runActivity(named: "検索結果としてフィルタリングされた歌をタップしたら、選択状態を変えることができる") { _ in
      // when
      poemPickerPage
        .tapCellof(number: 1)
        .tapCellof(number: 5)
        .cancelButton.tap()
      //   back to HomeScreen
      poemPickerPage.backToTopButton.tap()
      // then
      XCTAssert(homePage.numberOfSelecttedPoems(is: 98))
    }
  }
  
  func test_alertAppearsWhenStartGameWithoutSelectedPoem() {
    // given
    let poemPickerPage = homePage.goToPoemPickerPage()
    // when
    poemPickerPage.cancelAllButton.tap()
    poemPickerPage.backToTopButton.tap()
    // then
    XCTAssert(homePage.numberOfSelecttedPoems(is: 0))
    
    XCTContext.runActivity(named: "歌を全く選ばないまま試合を開始しようとすると、アラートが表示される") { _ in
      // when
      homePage.gameStartCell.tap()
      // then
      XCTAssert(homePage.noPoemSelectedAlert.exists)
    }
    XCTContext.runActivity(named: "アラート画面で「戻る」ボタンを押すと、アラートは消える") { acivity in
      // when
      homePage.dismissAlert()
      // then
      XCTAssertFalse(homePage.noPoemSelectedAlert.exists)
    }
    XCTContext.runActivity(named: "アラート画面が消えてトップ画面に戻ったとき、「試合開始」セルの選択は解除された状態になっている") { activity in
      XCTAssertFalse(homePage.gameStartCell.isSelected)
    }
  }
}


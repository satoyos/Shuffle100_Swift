//
//  AllPeomRecitedUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/01/04.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class AllPeomRecitedUITest: XCTestCase {
    let app = XCUIApplication()
    lazy var homePage = HomePage(app: app)
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }
    
    func test_GameEndViewAppears() {
        // when
        let pickerPage = homePage.goToPoemPickerPage()
        // then
        XCTAssert(pickerPage.exists, "歌選択画面に到達")
        // when
        pickerPage.allCancellButton.tap()
        pickerPage
            .tapCellof(number: 1)
            .backToTopPage()
        // then
        XCTAssert(homePage.numberOfSelecttedPoems(is: 1))

        // given
        let recitePage = homePage.gotoRecitePoemPage()
        XCTContext.runActivity(named: "試合を開始し、forward -> forward -> playで第1首の下の句の読み上げを開始する") { (activity) in
            // when
            recitePage
                .tapForwardButton(waiting: 1)
                .tapForwardButton(waiting: 1)
                .playButton.tap()
            // then
            XCTAssert(recitePage.recitePageAppears(number: 1, side: .shimo, total: 1))
        }
        // given
        let endPage = AllPoemRecitedPage(app: app)
        XCTContext.runActivity(named: "最後の歌を読み終えると、「試合終了」画面が現れる") { (activity) in
            // when
            recitePage.tapForwardButton()
            // then
            XCTAssert(endPage.exists, "「試合終了」画面に到達")
        }
        XCTContext.runActivity(named: "「トップに戻る」ボタンを押すと、トップ画面に戻る") { (activity) in
            // when
            endPage.backToTopButton.tap()
            // then
            XCTAssert(homePage.exists)
        }
    }
}

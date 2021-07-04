//
//  NgramPickerUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/05/06.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class NgramPickerUITest: XCTestCase {
    var app = XCUIApplication()
    lazy var homePage = HomePage(app: app)
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    
    func test_openNgramPicker() throws {
        // when
        let pickerPage = homePage.goToPoemPickerPage()
        // then
        XCTAssert(pickerPage.exists, "「歌を選ぶ」画面に到達")
        // when
        let ngramPage = pickerPage.gotoNgramPickerPage()
        // then
        XCTAssert(ngramPage.exists, "「1字目で選ぶ」画面に到達")
    }

    func test_tapFullSelectedCell() {
        // when
        let pickerPage = homePage.goToPoemPickerPage()
        XCTContext.runActivity(named: "1字決まり札を除く93枚を選んだ状態にする") { _ in
            // when
            pickerPage.selectAllButton.tap()
            let ngramPage = pickerPage.gotoNgramPickerPage()
            ngramPage
                .tapCell(type: .justOne)
                .backToPickerButton.tap()
        }
        pickerPage.backToTopButton.tap()
        // then
        XCTAssert(homePage.numberOfSelecttedPoems(is: 93), "トップ画面でも93酒が選ばれた状態になっている。")
    }
    
    func test_tapEmptySelectedCell() {
        // when
        let pickerPage = homePage.goToPoemPickerPage()
        pickerPage.cancelAllButton.tap()
        let ngramPage = pickerPage.gotoNgramPickerPage()
        ngramPage
            .tapCell(type: .shi)
            .backToPickerButton.tap()
        pickerPage.backToTopPage()
        // then
        XCTAssert(homePage.numberOfSelecttedPoems(is: 2))
    }
    
    func test_selectSeveralCells() {
        // when
        let pickerPage = homePage.goToPoemPickerPage()
        pickerPage.cancelAllButton.tap()
        let ngramPage = pickerPage.gotoNgramPickerPage()
        ngramPage // 2枚札を一通り選ぶ
            .tapCell(type: .u)
            .tapCell(type: .tsu)
            .tapCell(type: .shi)
            .tapCell(type: .mo)
            .tapCell(type: .yu)
        ngramPage.backToPickerButton.tap()
        pickerPage.backToTopPage()
        // then
        XCTAssert(homePage.numberOfSelecttedPoems(is: 10))
    }
}

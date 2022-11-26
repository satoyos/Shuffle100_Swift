//
//  OnWhatsNextScreenProtocol.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2022/11/26.
//  Copyright © 2022 里 佳史. All rights reserved.
//

import Foundation
import XCTest

protocol OnWhatsNextScreenTest {
    var app: XCUIApplication { get }
    var homePage: HomePage { get }
    
    func showTorifudaTest(mode: ReciteMode)
//    func refrainShimoTest()
//    func goNextTest()
}

extension OnWhatsNextScreenTest {
    func showTorifudaTest(mode: ReciteMode) {
        // given
        XCTContext.runActivity(named: "歌を1首(#4)だけ選んだ状態にする") { (activity) in
            // when
            let pickerPage = homePage.goToPoemPickerPage()
            // then
            XCTAssert(pickerPage.exists)
            // when
            pickerPage.cancelAllButton.tap()
            pickerPage.cellOf(number: 4).tap()
            pickerPage.backToTopButton.tap()
            // then
            XCTAssert(homePage.numberOfSelecttedPoems(is: 1))
        }
        // when
        let whatsNextPage = homePage.skipToWhatsNextPage(totalPoemsNum: 1, mode: mode)
        whatsNextPage.torifudaButton.tap()
        // then
        let fudaPage = TorifudaPage(app: app)
        XCTAssert(fudaPage.exists)
        XCTAssert(fudaPage.hasChar("ふ"))
        XCTAssert(fudaPage.hasChar("し"))
        XCTAssertFalse(fudaPage.hasChar("あ"))
        // when
        fudaPage.backToWhatsNextButton.tap()
        // then
        XCTAssert(whatsNextPage.exists)
    }
}

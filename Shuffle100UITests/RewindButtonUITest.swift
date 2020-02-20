//
//  RewindButtonUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/02/09.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class RewindButtonUITest: XCTestCase, RecitePoemScreenUITestUtils, HomeScreenUITestUtils, SetEnvUITestUtils {
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        setEnvIgnoreSavedData(app)
        app.launch()
    }

    func test_rewindInJokaGoBackToTop() {
        // given
        gotoRecitePoemScreen(app)
        // when
        let rewindButton = app.buttons["rewind"]
        sleep(1)
        rewindButton.tap()
        sleep(1)
        rewindButton.tap()
        // then
        XCTAssertTrue(app.navigationBars["トップ"].exists)
    }

    func test_rewindInNunberedPoem_atKami() {
        XCTContext.runActivity(named: "2首目の上の句まで進む") { (activiti) in
            gotoRecitePoemScreen(app)
            app.buttons["forward"].tap()
            app.buttons["forward"].tap()
            app.buttons["forward"].tap()
            app.buttons["forward"].tap()
            XCTAssert(app.staticTexts["2首め:上の句 (全100首)"].exists)
        }
        XCTContext.runActivity(named: "2首目の上の句を読み始めた状態でrewindボタンを2回押すと、1首めの下の句に戻る") { (activiti) in
            // given
            let rewindButton = app.buttons["rewind"]
            sleep(1)
            // when
            rewindButton.tap()
            rewindButton.tap()
            // then
            XCTAssert(app.staticTexts["1首め:下の句 (全100首)"].exists)
        }
    }
    
    func test_rewindInNumberedPoem_atShimo() {
        XCTContext.runActivity(named: "1首目の下の句まで進む") { (activiti) in
            gotoRecitePoemScreen(app)
            app.buttons["forward"].tap()
            app.buttons["forward"].tap()
            app.buttons["forward"].tap()
            XCTAssert(app.staticTexts["1首め:下の句 (全100首)"].exists)
        }
        XCTContext.runActivity(named: "下の句を読み始めた状態でrewindボタンを2回押すと、上の句に戻る") { (activiti) in
            // given
            let rewindButton = app.buttons["rewind"]
            sleep(1)
            // when
            rewindButton.tap()
            rewindButton.tap()
            // then
            XCTAssert(app.staticTexts["1首め:上の句 (全100首)"].exists)
        }
    }
    
}

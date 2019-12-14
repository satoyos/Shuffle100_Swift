//
//  RecitePoemScreenUITest.swift
//  Shuffle100UITests
//
//  Created by 里 佳史 on 2019/09/16.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest
import FontAwesome_swift

class RecitePoemScreenUITest: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchEnvironment = ["IS_TESTING" : "1"]
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func test_PlayButtonFlipsOnTouch() {
//        // given
//        gotoRecitePoemScreenFromHome()
//        let playButton = app.buttons["play"]
//        let waitingPauseID = "waitingForPause"
//        let waitingPlayID = "waitingForPlay"
//
//        XCTContext.runActivity(named: "RecitePoemScreenに遷移した時点では、PlayButtonはPause待ち状態") { (activity) in
//            XCTAssert(app.buttons[waitingPauseID].exists)
//        }
//        XCTContext.runActivity(named: "PlayButtonを一度タップすると、Play待ち状態になる") { (activity) in
//            // when
//            sleep(1)
//            playButton.tap()
//            // then
//            sleep(1)
//            XCTAssertFalse(app.buttons[waitingPauseID].exists)
//            XCTAssert(app.buttons[waitingPlayID].exists)
//        }
//        XCTContext.runActivity(named: "次にPlayButtonを押すと、状態は反転する") {
//            (activity) in
//            // when
//            // when
//            sleep(1)
//            playButton.tap()
//            // then
//            XCTAssert(app.buttons[waitingPauseID].exists)
//            XCTAssertFalse(app.buttons[waitingPlayID].exists)
//        }
//
//    }

    private func gotoRecitePoemScreenFromHome() {
        // when
        app.tables.cells["GameStartCell"].tap()
        // then
        XCTAssert(app.staticTexts["序歌"].exists)
    }
}

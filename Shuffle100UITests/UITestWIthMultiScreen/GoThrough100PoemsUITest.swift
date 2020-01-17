//
//  GoThrough100PoemsUITest.swift
//  Shuffle100UITests
//
//  Created by 里 佳史 on 2019/11/27.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

class GoThrough100PoemsUITest: XCTestCase, HomeScreenUITestUtils, RecitePoemScreenUITestUtils {
    var app = XCUIApplication()
    
    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_goThroghWithSkipForward() {
        XCTContext.runActivity(named: "まず序歌へ") { (activiti) in
            gotoRecitePoemScreen(app)
        }

        for i in (1...20) {
            XCTContext.runActivity(named: "forwardボタンを押すと、\(i)首めの上の句へ") { (activiti) in
                tapForwardButton(app)
                sleep(1)
                XCTAssert(app.staticTexts["\(i)首め:上の句 (全100首)"].exists)
            }
            XCTContext.runActivity(named: "上の句の読み上げ後、一旦止まり、Playボタンを押すと、下の句へ。") { (activiti) in
                
                tapForwardButton(app)
                tapPlayButton(app)
                sleep(1)
                XCTAssert(app.staticTexts["\(i)首め:下の句 (全100首)"].exists)
            }
        }

        
    }
}

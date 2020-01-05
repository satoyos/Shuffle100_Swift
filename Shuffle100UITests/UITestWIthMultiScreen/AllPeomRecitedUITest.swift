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
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_GameEndViewAppears() {
        
    }

    
    private func gotoPoemPickerScreenTest() {
        XCTContext.runActivity(named: "「取り札を用意する歌」セルをタップすると、歌選択画面に遷移する") { (activity) in
            app.tables/*@START_MENU_TOKEN@*/.staticTexts["取り札を用意する歌"]/*[[".cells[\"poemsCell\"].staticTexts[\"取り札を用意する歌\"]",".staticTexts[\"取り札を用意する歌\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
            XCTAssert(app.navigationBars["歌を選ぶ"].exists)
        }
    }
}

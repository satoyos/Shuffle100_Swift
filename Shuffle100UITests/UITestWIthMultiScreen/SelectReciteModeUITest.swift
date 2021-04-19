//
//  SelectReciteModeUITest.swift
//  Shuffle100UITests
//
//  Created by 里 佳史 on 2019/03/03.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

class SelectReciteModeUITest: XCTestCase, HomeScreenUITestUtils {
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_HomeScreenReflectsSelectedMode() {
        var selectModePage: SelectModePage?
        XCTContext.runActivity(named: "トップ画面で「読み上げモード」をタップすると、モード選択画面に遷移する"){
            (acitivity) in
            selectModePage = gotoSelectModeScreen()
        }
        
        guard let modePage = selectModePage else {
            XCTFail("SelectModePageオブジェクトが取得できていない")
            return
        }
        
        XCTContext.runActivity(named: "初心者モードを選んでトップ画面に戻ると、その結果が反映されている") { (acitivity) in
            modePage
                .selectMode(.beginner)
                .backToTopButton.tap()
            // then
            XCTAssertTrue(app.cells.staticTexts["初心者"].exists)
            // in BeginnerMode, fake mode chell should disappear
            XCTAssertFalse(app.switches["fakeModeSwitch"].exists)
        }
    }

}

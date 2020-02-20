//
//  SelectReciteModeUITest.swift
//  Shuffle100UITests
//
//  Created by 里 佳史 on 2019/03/03.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

class SelectReciteModeUITest: XCTestCase, HomeScreenUITestUtils, SetEnvUITestUtils {
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        setEnvIgnoreSavedData(app)
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_HomeScreenReflectsSelectedMode() {
        XCTContext.runActivity(named: "トップ画面で「読み上げモード」をタップすると、モード選択画面に遷移する"){
            (acitivity) in
            gotoSelectModeScreen(app)
        }
        
        XCTContext.runActivity(named: "初心者モードを選んでトップ画面に戻ると、その結果が反映されている") { (acitivity) in
            // when
            app.pickerWheels.element.adjust(toPickerWheelValue: "初心者 (チラし取り)")
            app.buttons["トップ"].tap()
            // then
            // then
            XCTAssertTrue(app.cells.staticTexts["初心者"].exists)
            // in BeginnerMode, fake mode chell should disappear
            XCTAssertFalse(app.switches["fakeModeSwitch"].exists)
        }
    }

}

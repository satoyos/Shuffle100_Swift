//
//  SelectSingerUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/02/13.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class SelectSingerUITest: XCTestCase, HomeScreenUITestUtils {
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    func test_HomeScreenReflectsSelectedSinger() {
        gotoSelectSingerScreen(app)
        
        XCTContext.runActivity(named: "「いなばくん」を選んでトップ画面に戻ると、その結果が反映されている") { (acitivity) in
            // given
            let inabaLabel = "いなばくん（人間）"
            // when
            app.pickerWheels.element.adjust(toPickerWheelValue: inabaLabel)
            app.buttons["トップ"].tap()
            // then
            XCTAssertTrue(app.cells.staticTexts[inabaLabel].exists)
        }
    }

}

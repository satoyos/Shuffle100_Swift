//
//  FudaSetSavingUITest.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/05/20.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class FudaSetSavingUITest: XCTestCase, HomeScreenUITestUtils {
    var app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        app.launch()
    }


    func test_showActionSheetForFudaSetSaving() throws {
        // given
        gotoPoemPickerScreen(app)
        XCTContext.runActivity(named: "「保存」ボタンを押すと、アクションシートが現れる") { activity in
            // when
            app.buttons["保存"].tap()
            // then
            XCTAssert(app.staticTexts["選んでいる札をどのように保存しますか？"].exists)
            XCTAssert(app.buttons["新しい札セットとして保存する"].exists)
            // iPadでは、ActionSheetでキャンセルボタンが表示されない。
            if UIDevice.current.userInterfaceIdiom == .phone {
                XCTAssert(app.buttons["キャンセル"].exists)
            }
        }
    }

}

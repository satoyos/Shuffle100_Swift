//
//  ExitGameUITestUtils.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/05/06.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

protocol ExitGameUITestUtils {
    func exitGameSuccessfully(_ app: XCUIApplication)
}

extension ExitGameUITestUtils {
    func exitGameSuccessfully(_ app: XCUIApplication) {
        XCTContext.runActivity(named: "Exitボタンを押すと、確認のダイアログが現れる") { (activiti) in
            // when
            app.buttons["exit"].tap()
            // then
            XCTAssert(app.alerts.staticTexts["試合を終了しますか？"].exists)
        }
        
        XCTContext.runActivity(named: "確認ダイアログで「終了する」を押すと、トップ画面に戻る") {
            (activity) in
            // when
            app.alerts.buttons["終了する"].tap()
            sleep(1)
            // then
            XCTAssert(app.navigationBars["トップ"].exists)
        }
    }
}

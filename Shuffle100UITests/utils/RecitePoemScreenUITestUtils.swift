//
//  RecitePoemScreenUITestUtils.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/01/17.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

protocol RecitePoemScreenUITestUtils: HomeScreenUITestUtils {
    func tapForwardButton(_ app: XCUIApplication) -> Void
    func tapRewindButton(_ app: XCUIApplication) -> Void
    func tapPlayButton(_ app: XCUIApplication) -> Void
    func gotoWhatsNextScreen(_ app: XCUIApplication, poemsNumber:Int) -> Void
}

extension RecitePoemScreenUITestUtils {
    func tapForwardButton(_ app: XCUIApplication) {
        app.buttons["forward"].tap()
    }
    
    func tapRewindButton(_ app: XCUIApplication) {
         app.buttons["rewind"].tap()
    }
    
    func tapPlayButton(_ app: XCUIApplication) {
        app.buttons["play"].tap()
    }
    
    func gotoWhatsNextScreen(_ app: XCUIApplication, poemsNumber:Int = 100) {
        XCTContext.runActivity(named: "初心者モードを選択") { (activity) in
            // when
            gotoSelectModeScreen(app)
            app.pickerWheels.element.adjust(toPickerWheelValue: "初心者 (チラし取り)")
            app.buttons["トップ"].tap()
            // then
            XCTAssert(app.cells.staticTexts["初心者"].exists)
        }
        XCTContext.runActivity(named: "そして序歌へ") { (activity) in
            gotoRecitePoemScreen(app)
        }
        XCTContext.runActivity(named: "forwardボタンを押すと、1首めの上の句へ") { (activity) in
            tapForwardButton(app)
            XCTAssert(app.staticTexts["1首め:上の句 (全\(poemsNumber)首)"].exists)
        }
        XCTContext.runActivity(named: "上の句の読み上げ後、自動的に下の句へ") { (activity) in
            
            tapForwardButton(app)
            XCTAssert(app.staticTexts["1首め:下の句 (全\(poemsNumber)首)"].exists)
        }
        XCTContext.runActivity(named: "下の句が終わると、「次はどうする？」画面が現れる") { (activity) in
            
            tapForwardButton(app)
            XCTAssert(app.staticTexts["次はどうする？"].exists)
        }
    }
}

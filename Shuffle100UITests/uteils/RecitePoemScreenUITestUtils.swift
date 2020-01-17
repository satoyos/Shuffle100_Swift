//
//  RecitePoemScreenUITestUtils.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/01/17.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

protocol RecitePoemScreenUITestUtils {
    func tapForwardButton(_ app: XCUIApplication) -> Void
    func tapRewindButton(_ app: XCUIApplication) -> Void
    func tapPlayButton(_ app: XCUIApplication) -> Void
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
}

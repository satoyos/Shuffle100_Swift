//
//  SetEnvUITestUtils.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/02/16.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

protocol SetEnvUITestUtils {
    func setEnvIgnoreSavedData(_ app: XCUIApplication) -> Void
    func setEnvLoadSavedData(_ app: XCUIApplication) -> Void
    func setEnvWillSaveData(_ app: XCUIApplication) -> Void
    func setEnvWontSaveData(_ app: XCUIApplication) -> Void
}

extension SetEnvUITestUtils {
    func setEnvIgnoreSavedData(_ app: XCUIApplication) {
        app.launchEnvironment["IGNORE_SAVED_DATA"] = "1"
    }
    
    func setEnvLoadSavedData(_ app: XCUIApplication) {
        app.launchEnvironment["IGNORE_SAVED_DATA"] = "0"
    }
    
    func setEnvWillSaveData(_ app: XCUIApplication) {
        app.launchEnvironment["WONT_SAVE_DATA"] = "0"
    }
    
    func setEnvWontSaveData(_ app: XCUIApplication) {
        app.launchEnvironment = ["WONT_SAVE_DATA": "1"]
    }
    
    func setEnvIgnoreSavedDataAndWillSaveData(_ app: XCUIApplication) {
        app.launchEnvironment["IGNORE_SAVED_DATA"] = "1"
        app.launchEnvironment["WONT_SAVE_DATA"] = "0"
    }
}

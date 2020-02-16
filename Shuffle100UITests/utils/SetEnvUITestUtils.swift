//
//  SetEnvUITestUtils.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2020/02/16.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

protocol SetEnvUITestUtils {
    func setEnvTesting(_ app: XCUIApplication) -> Void
}

extension SetEnvUITestUtils {
    func setEnvTesting(_ app: XCUIApplication) {
        app.launchEnvironment = ["IS_TESTING": "1"]
    }
}

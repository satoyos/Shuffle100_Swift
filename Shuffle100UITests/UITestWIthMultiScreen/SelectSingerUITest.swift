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
        app.launch()
    }

    func test_HomeScreenReflectsSelectedSinger() {
        gotoSelectSingerScreen(app)
        
        // 続きを書く！
    }

}

//
//  KeyWindowProtocolTest.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2022/05/08.
//  Copyright © 2022 里 佳史. All rights reserved.
//

import XCTest

class KeyWindowProtocolTest: XCTestCase, AppWindow {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_CanGetUIWindow() {
        // when
        let window = keyWindow
        // then
        XCTAssertNotNil(window)
        XCTAssert(window.frame.width > 0)
    }
}

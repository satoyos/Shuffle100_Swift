//
//  WhatsNextScreenTest.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2020/04/27.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class WhatsNextScreenTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_initialScreen() {
        // given
        let screen = WhatsNextViewController()
        // when
        screen.loadViewIfNeeded()
        // then
        XCTAssertEqual(screen.title, "次はどうする？")
    }

}

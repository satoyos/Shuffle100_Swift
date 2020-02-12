//
//  SelectSingerScreenTest.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2020/02/12.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest
@testable import Shuffle100

class SelectSingerScreenTest: XCTestCase {
    var screen: SelectSingerViewController!

    override func setUp() {
        screen = SelectSingerViewController()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_titleText() {
        // when
        screen.loadViewIfNeeded()
        // then
        XCTAssertEqual(screen.title, "読手を選ぶ")
    }

}

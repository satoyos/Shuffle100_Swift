//
//  DigitsPickerScreen01Test.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2023/05/03.
//  Copyright © 2023 里 佳史. All rights reserved.
//

import XCTest

final class DigitsPickerScreen01Test: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_initialScreen() throws {
        // given
        let screen = DigitsPickerScreen01()
        // when
        screen.loadViewIfNeeded()
        // then
        XCTAssertEqual(screen.title, "1の位の数で選ぶ")
        XCTAssertNotNil(screen.tableView)
    }
}

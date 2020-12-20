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
    func test_initialScreen() {
        // given
        let screen = SelectSingerScreen()
        // when
        screen.loadViewIfNeeded()
        let rowNum = screen.pickerView(screen.picker, numberOfRowsInComponent: 0)
        // then
        XCTAssertEqual(screen.title, "読手を選ぶ")
        XCTAssertEqual(rowNum, 2)
    }

}

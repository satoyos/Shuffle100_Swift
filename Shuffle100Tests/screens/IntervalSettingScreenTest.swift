//
//  IntervalSettingScreenTest.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2020/03/08.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest
@testable import Shuffle100

class IntervalSettingScreenTest: XCTestCase {

    func test_initialScreen() {
        // given, when
        let screen = IntervalSettingViewController()
        // then
        XCTAssertNotNil(screen)
        // when
        screen.loadViewIfNeeded()
        // then
        XCTAssertEqual(screen.title, "歌の間隔の調整")
    }
}

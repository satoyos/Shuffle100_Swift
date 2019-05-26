//
//  RecitingConfigTest.swift
//  Shuffle100Tests
//
//  Created by 里 佳史 on 2019/05/25.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

class RecitingConfigTest: XCTestCase {

    func test_initWithoutParameters() {
        // given, when
        let sut = RecitingConfig()
        // then
        XCTAssertEqual(sut.volume, 1.0)
        XCTAssertEqual(sut.interval, 1.10)
        XCTAssertEqual(sut.kamiShimoInterval, 1.0)
    }

}

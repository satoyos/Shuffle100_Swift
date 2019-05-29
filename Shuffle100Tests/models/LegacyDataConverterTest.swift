//
//  LegacyDataConverterTest.swift
//  Shuffle100Tests
//
//  Created by 里 佳史 on 2019/05/29.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

class LegacyDataConverterTest: XCTestCase {

    func test_convertSelectedStatus100() {
        // given
        var testBools = Bool100.allFalseBoolArray()
        for i in [2,3,5] {testBools[i] = true}
        let testSelectedStatus100 = SelectedStatus100(status: testBools)
        // when
        let state100 = LegacyDataConverter.convertSelectedStatus100(testSelectedStatus100)
        // then
        XCTAssertEqual(state100.selectedNum, 3)
    }

}

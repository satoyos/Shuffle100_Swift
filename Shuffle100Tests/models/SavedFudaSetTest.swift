//
//  SavedFudaSetTest.swift
//  Shuffle100Tests
//
//  Created by 里 佳史 on 2019/05/29.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

class SavedFudaSetTest: XCTestCase {
    func test_initWithParameters() {
        // given, when
        let set = SavedFudaSet()
        // then
        XCTAssertEqual(set.name, "名前を付けましょう")
        XCTAssertEqual(set.bools.count, 100)
        for i in 0..<100 {
            XCTAssertEqual(set.bools[i], true)
        }
    }
    
}

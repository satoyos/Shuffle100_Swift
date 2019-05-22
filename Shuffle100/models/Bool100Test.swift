//
//  Bool100Test.swift
//  Shuffle100Tests
//
//  Created by 里 佳史 on 2019/05/22.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

class Bool100Test: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //////// Bool100関連のユーティリティメソッドをTDDで作っていく！
    
    func test_allSelected() {
        // when
        let sut = Bool100.allSelected()
        // then
        let trueCount = sut.bools.filter{$0}.count
        XCTAssertEqual(trueCount, 100)
    }
}

//
//  NgramNumbersTest.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2020/05/10.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest
@testable import Shuffle100

class NgramNumbersTest: XCTestCase {
    let numbers = NgramDataFactory.createNgramNumbersDic()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_staticInstanceExists() {
        XCTAssertNotNil(numbers)
    }
    

    func test_correctDic() {
        XCTAssertEqual(numbers["ha"], [2, 9, 67, 96])
        XCTAssertEqual(numbers["mu"], [87])
        XCTAssertEqual(numbers["i"]?.count, 3)
        XCTAssertEqual(numbers["a"]?.count, 16)
        XCTAssertNotNil(numbers["just_one"])
        XCTAssertEqual(numbers["just_one"]?.count, 7)
    }

}

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
    }

}

//
//  FiveColorsTest.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2020/09/11.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest
@testable import Shuffle100

class FiveColorsTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_initFiveColorData () throws {
        // given, when
        let testName = "あっちょんぶりけ"
        let colorData =
            FiveColorData(type: .green,                           poemNumbers: [1, 3, 5, 7], name: testName)
        // then
        XCTAssertEqual(colorData.type, FiveColors.green)
        XCTAssertEqual(colorData.poemNumbers.count, 4)
        XCTAssertEqual(colorData.name, testName)
    }

    func test_FiveColorsDic() {
        // given, when
        let colorsDic = FiveColorsDataHolder.sharedDic
        // then
        XCTAssertNotNil(colorsDic[.blue])
        XCTAssertNotNil(colorsDic[.yellow])
        XCTAssertEqual(colorsDic[.yellow]?.name, "黄")
    }

}

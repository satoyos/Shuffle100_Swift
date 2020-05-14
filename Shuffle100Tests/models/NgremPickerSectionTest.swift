//
//  NgremPickerSectionTest.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2020/05/14.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class NgremPickerSectionTest: XCTestCase {
    let sections = NgramDataFactory.createNgramPickerSctions()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_fistItemIsJustOne() throws {
        XCTAssertEqual(sections[0].sectionId, "one")
        XCTAssertEqual(sections[0].items.count, 1)
        let firstItem = sections[0].items.first
        XCTAssertEqual(firstItem?.id, "just_one")
    }

}

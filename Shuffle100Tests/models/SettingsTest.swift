//
//  SettingsTest.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2021/03/19.
//  Copyright © 2021 里 佳史. All rights reserved.
//

import XCTest

class SettingsTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_fakeModeMustBeDisabledAfterChangingReciteModefromNormar() throws {
        // given
        let settings = Settings()
        XCTAssertEqual(settings.reciteMode, .normal)
        settings.fakeMode = true
        // when
        settings.reciteMode = .beginner
        // then
        XCTAssertEqual(settings.fakeMode, false)
    }
}

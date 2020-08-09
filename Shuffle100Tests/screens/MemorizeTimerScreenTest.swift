//
//  MemorizeTimerScreenTest.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2020/08/06.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest
@testable import Shuffle100

class MemorizeTimerScreenTest: XCTestCase {
    var screen = MemorizeTimerViewController()

    override func setUpWithError() throws {
        screen.loadViewIfNeeded()
        screen.view.layoutIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_initialLayout() throws {
        XCTAssertEqual(screen.title, "暗記時間タイマー")
        let charLabelSize = SizeFactory.createSizeByDevice().memorizeTimerLabelPointSize() / 3
        XCTAssertEqual(screen.minCharLabel.frame.width, charLabelSize, accuracy: 1.0)
    }
}

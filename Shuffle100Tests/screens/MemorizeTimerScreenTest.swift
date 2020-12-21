//
//  MemorizeTimerScreenTest.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2020/08/06.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest
import FontAwesome_swift
@testable import Shuffle100

class MemorizeTimerScreenTest: XCTestCase {
    var screen = MemorizeTimerScreen()

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
        XCTAssertEqual(screen.playButton.titleLabel?.text, String.fontAwesomeIcon(name: .play))
        XCTAssertFalse(screen.isTimerRunning)
        XCTContext.runActivity(named: "暗記時間の初期表示は「15分00秒」") { _ in
            XCTAssertEqual(screen.minLabel.text, "15")
            XCTAssertEqual(screen.secLabel.text, "00")
        }
    }
}

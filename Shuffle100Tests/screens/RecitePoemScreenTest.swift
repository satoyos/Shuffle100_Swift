//
//  RecitePoemScreenTest.swift
//  Shuffle100Tests
//
//  Created by 里 佳史 on 2019/06/08.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

class RecitePoemScreenTest: XCTestCase {
    var screen = RecitePoemViewController()

    override func setUp() {
        screen.loadViewIfNeeded()
        screen.view.layoutIfNeeded()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_initialLayout() {
        XCTAssertEqual(screen.view.backgroundColor, Color.natsumushi.UIColor)
        XCTAssertEqual(screen.recitePoemView.headerContainer.backgroundColor, Color.natsumushi.UIColor)
        XCTAssertEqual(screen.recitePoemView.headerContainer.frame.size.height, 40)
        XCTAssertGreaterThan(screen.recitePoemView.playButton.frame.size.width, 100)
    }

}

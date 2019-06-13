//
//  RecitePoemScreenTest.swift
//  Shuffle100Tests
//
//  Created by 里 佳史 on 2019/06/08.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

class RecitePoemScreenTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_layout() {
        let screen = RecitePoemViewController()
        screen.loadViewIfNeeded()
        screen.view.layoutIfNeeded()
        XCTAssertEqual(screen.view.backgroundColor, .white)
        XCTAssertEqual(screen.headerContainer.backgroundColor, Color.natsumushi.UIColor)
        XCTAssertEqual(screen.headerContainer.frame.size.height, 40)
    }

}

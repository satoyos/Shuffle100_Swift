//
//  HelpDetailScreenTest.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2020/06/26.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest
@testable import Shuffle100

class HelpDetailScreenTest: XCTestCase {

    func test_initialScreen() throws {
        // given
        let screen = HelpDetailScreen(title: "aaa", htmlFileName: "html/options.html")
        // when
        screen.loadViewIfNeeded()
        // then
        XCTAssertEqual(screen.title, "aaa")
        XCTAssertEqual(screen.view.subviews.count, 1)
    }


}

//
//  HelpListScreenTest.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2020/06/20.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest
@testable import Shuffle100

class HelpListScreenTest: XCTestCase {

    func test_initialScreen() throws {
        // given, when
        let screen = HelpListViewController()

        XCTAssertNotNil(screen)
//    // when
//    screen.loadViewIfNeeded()
//    // then
//    XCTAssertEqual(screen.title, "いろいろな設定")
//    // then
//    let tableView = screen.tableView
//    XCTAssertNotNil(tableView)
//    XCTAssertEqual(screen.tableView(tableView!, numberOfRowsInSection: 0), 3)
//    let firstCell = screen.tableView(tableView!, cellForRowAt: IndexPath(row: 0, section: 0))
//    XCTAssertEqual(firstCell.textLabel?.text, "歌と歌の間隔")
//    XCTAssertEqual(firstCell.detailTextLabel?.text, "1.10")
//    let secondCell = screen.tableView(tableView!, cellForRowAt: IndexPath(row: 1, section: 0))
//    XCTAssertEqual(secondCell.detailTextLabel?.text, "1.00")
//    let thirdCell = screen.tableView(tableView!, cellForRowAt: IndexPath(row: 2, section: 0))
//    XCTAssertEqual(thirdCell.detailTextLabel?.text, "100%")

    }

}

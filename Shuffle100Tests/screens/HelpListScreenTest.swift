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
        // given
        let coordinator = HelpListCoordinator(navigationController: UINavigationController())
        // given, when
        coordinator.start()
        guard let screen = coordinator.screen as? HelpListViewController else {
            XCTAssert(false, "Failed to fetch HelpListScreen")
            return
        }
        // then
        XCTAssertNotNil(screen)
        // when
        screen.loadViewIfNeeded()
        // then
        XCTAssertEqual(screen.title, "ヘルプ")
        // then
        let tableView = screen.tableView
        XCTAssertNotNil(tableView)
        XCTAssertEqual(tableView?.numberOfSections, 2)
        XCTAssertEqual(screen.tableView(tableView!, titleForHeaderInSection: 0), "使い方")
        let firstCell = screen.tableView(tableView!, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(firstCell.textLabel?.text, "設定できること")
        XCTAssertEqual(firstCell.accessoryType, .disclosureIndicator)
//    XCTAssertEqual(firstCell.detailTextLabel?.text, "1.10")
//    let secondCell = screen.tableView(tableView!, cellForRowAt: IndexPath(row: 1, section: 0))
//    XCTAssertEqual(secondCell.detailTextLabel?.text, "1.00")
//    let thirdCell = screen.tableView(tableView!, cellForRowAt: IndexPath(row: 2, section: 0))
//    XCTAssertEqual(thirdCell.detailTextLabel?.text, "100%")

    }

}

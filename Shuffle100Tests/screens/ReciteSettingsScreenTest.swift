//
//  ReciteSettingsScreenTest.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2020/03/01.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest
@testable import Shuffle100

class ReciteSettingsScreenTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_initialScreen() {
        // given, when
        let screen = ReciteSettingsScreen()
        // then
        XCTAssertNotNil(screen)
        // when
        screen.loadViewIfNeeded()
        // then
        XCTAssertEqual(screen.title, "いろいろな設定")
        // then
        let tableView = screen.tableView
        XCTAssertNotNil(tableView)
        
        // 一旦、感想戦モードの実装はユーザから隠す
//        XCTAssertEqual(screen.tableView(tableView!, numberOfRowsInSection: 0), 4)
        XCTAssertEqual(screen.tableView(tableView!, numberOfRowsInSection: 0), 3)

        let firstCell = screen.tableView(tableView!, cellForRowAt: IndexPath(row: 0, section: 0))
        guard let firstConfig = firstCell.contentConfiguration as? UIListContentConfiguration else {
            XCTAssert(false, "firstCell.contentConfiguration should be set!")
            return
        }
        XCTAssertEqual(firstConfig.text, "歌と歌の間隔")
        XCTAssertEqual(firstConfig.secondaryText, "1.10")
        let secondCell = screen.tableView(tableView!, cellForRowAt: IndexPath(row: 1, section: 0))
        guard let secondConfig = secondCell.contentConfiguration as? UIListContentConfiguration else {
            XCTAssert(false, "secondCell.contentConfiguration should be set!")
            return
        }
        XCTAssertEqual(secondConfig.secondaryText, "1.00")
        let thirdCell = screen.tableView(tableView!, cellForRowAt: IndexPath(row: 2, section: 0))
        guard let thirdConfig = thirdCell.contentConfiguration as? UIListContentConfiguration else {
            XCTAssert(false, "thirdCell.contentConfiguration should be set!")
            return
        }
        XCTAssertEqual(thirdConfig.secondaryText, "100%")
    }

    // 一旦、感想戦モードの実装はユーザから隠す

//    func test_fourthCellHasSwith() {
//        // given
//        let screen = ReciteSettingsScreen()
//        // when
//        screen.loadViewIfNeeded()
//        // then
//        let fourthCell = screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: 3, section: 0))
//        XCTAssertNotNil(fourthCell)
//        XCTAssertNotNil(fourthCell.accessoryView)
//        XCTAssert(fourthCell.accessoryView!.isKind(of: UISwitch.self))
//    }
    
}

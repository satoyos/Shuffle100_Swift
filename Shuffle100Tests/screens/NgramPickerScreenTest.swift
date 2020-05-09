//
//  NgramPickerScreenTest.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2020/05/08.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest
import BBBadgeBarButtonItem
@testable import Shuffle100

class NgramPickerScreenTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_initialScreen() throws {
        // given
        let screen = NgramPickerViewController()
        // when
        screen.loadViewIfNeeded()
        // then
        XCTAssertEqual(screen.title, "1字目で選ぶ")
        XCTAssertNotNil(screen.tableView)
        let buttonItem = screen.navigationItem.rightBarButtonItem as? BBBadgeBarButtonItem
        XCTAssertNotNil(buttonItem)
        XCTAssertEqual(buttonItem?.badgeValue, "100首")
    }
    
    func test_loadDataSourceFile() {
        // given
        let screen = NgramPickerViewController()
        // when
        screen.loadViewIfNeeded()
        // then
        XCTAssertEqual(screen.sections.count, 9)
        let nijiSection = screen.sections.first(where: {$0.sectionId == "two"})
        XCTAssertNotNil(nijiSection)
        XCTAssertEqual(nijiSection?.items.count, 5)
        let numOf2charsGroup = screen.tableView(screen.tableView, numberOfRowsInSection: 1)
        XCTAssertEqual(numOf2charsGroup, 5)
        let titleOf2charsGroup = screen.tableView(screen.tableView, titleForHeaderInSection: 1)
        XCTAssertEqual(titleOf2charsGroup, "二枚札")
        let cellOfTopIn2CharsGroup = screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: 0, section: 1))
        XCTAssertEqual(cellOfTopIn2CharsGroup.textLabel?.text, "「う」で始まる歌")
        XCTAssertNotNil(cellOfTopIn2CharsGroup.imageView?.image)
    }
    
}

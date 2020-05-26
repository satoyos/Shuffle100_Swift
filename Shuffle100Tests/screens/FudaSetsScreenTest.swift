//
//  FudaSetsScreenTest.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2020/05/25.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest
@testable import Shuffle100

class FudaSetsScreenTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_initialScreen() throws {
        // given, when
        let screen = FudaSetsViewController()
        // then
        XCTAssertNotNil(screen)
        // when
        screen.loadViewIfNeeded()
        // then
        XCTAssertEqual(screen.title, "作った札セットから選ぶ")
        XCTAssertNotNil(screen.tableView)
    }
    
    func test_eachCellShowsFudaSetSize() {
        // given
        let screen = FudaSetsViewController()
        screen.loadViewIfNeeded()
        // when
        let set = SavedFudaSet(name: "aaa", state100: SelectedState100.init(bool100: Bool100.allSelected()))
        screen.settings.savedFudaSets.append(set)
        // then
        let cell = screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell.textLabel?.text, "aaa")
        XCTAssertEqual(cell.detailTextLabel?.text, "100首")
    }

}

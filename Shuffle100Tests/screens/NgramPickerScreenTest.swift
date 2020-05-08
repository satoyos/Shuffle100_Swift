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
    
}

//
//  DigitsPickerScreen10Test.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2023/05/15.
//  Copyright © 2023 里 佳史. All rights reserved.
//

import XCTest

final class DigitsPickerScreen10Test: XCTestCase, SelectedNumBadgeTest {

    func test_initialScreen() {
        // given
        let screen = DigitsPickerScreen10()
        // when
        screen.loadViewIfNeeded()
        // then
        XCTAssertEqual(screen.title,"10の位の数で選ぶ")
        XCTAssertNotNil(screen.tableView)
        let buttonItem = screen.navigationItem.rightBarButtonItems?.last as? UIBarButtonItem
        XCTAssertNotNil(buttonItem)
        XCTAssertEqual(badgeView(of: screen)?.text, "100首")
    }

}

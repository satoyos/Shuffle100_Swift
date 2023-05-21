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
    
    func test_dataSource() {
        // given
        let screen = DigitsPickerScreen10()
        // when
        screen.loadViewIfNeeded()
        // then
        XCTAssertEqual(screen.tableView.numberOfSections, 1)
        let numOfRows = screen.tableView(screen.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numOfRows, 10)
        // when
        let thirdCell = cellFor(screen, row: 2)
        guard let content = thirdCell.contentConfiguration as? UIListContentConfiguration else {
            XCTFail("failure in getting config of thirdCell ")
            return
        }
        // then
        XCTAssertEqual(content.text, "3")
    }

    private func cellFor(_ screen: DigitsPickerScreen10, row: Int) -> SelectByGroupCell {
        screen.cellIn1stSection(row: row) as! SelectByGroupCell
    }
}

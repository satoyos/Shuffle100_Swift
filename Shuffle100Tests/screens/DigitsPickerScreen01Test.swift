//
//  DigitsPickerScreen01Test.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2023/05/03.
//  Copyright © 2023 里 佳史. All rights reserved.
//

import XCTest

final class DigitsPickerScreen01Test: XCTestCase, SelectedNumBadgeTest {

    func test_initialScreen() throws {
        // given
        let screen = DigitsPickerScreen01()
        // when
        screen.loadViewIfNeeded()
        // then
        XCTAssertEqual(screen.title, "1の位の数で選ぶ")
        XCTAssertNotNil(screen.tableView)
        let buttonItem = screen.navigationItem.rightBarButtonItems?.last as? UIBarButtonItem
        XCTAssertNotNil(buttonItem)
        XCTAssertEqual(badgeView(of: screen)?.text, "100首")
    }
    
    func test_dataSource() {
        // given
        let screen = DigitsPickerScreen01()
        // when
        screen.loadViewIfNeeded()
        // then
        XCTAssertEqual(screen.tableView.numberOfSections, 1)
        let numOfRows = screen.tableView(screen.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numOfRows, 10)
        
        // when
        let secondCell = cellFor(screen, section: 0, row: 1)
        guard let content = secondCell.contentConfiguration
                as? UIListContentConfiguration else {
            XCTFail("failure in getting config of secondCell ")
            return
        }
        // then
        XCTAssertEqual(content.text, "2")
        XCTAssertNotNil(content.image)
        XCTAssertEqual(content.secondaryText, "歌番号: 2, 12, 22, 32, 42, 52, 62, 72, 82, 92")
    }
    
    private func cellFor(_ screen: DigitsPickerScreen01, section: Int, row: Int) -> NgramPickerTableCell {
        let cell = screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: row, section: section))
        return cell as! NgramPickerTableCell
    }
}

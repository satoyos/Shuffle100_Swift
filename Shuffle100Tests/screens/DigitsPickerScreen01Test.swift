//
//  DigitsPickerScreen01Test.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2023/05/03.
//  Copyright © 2023 里 佳史. All rights reserved.
//

@testable import Shuffle100
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
        let secondCell = cellFor(screen, row: 1)
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
    
    func test_partialSelected() {
        // given
        let settings = Settings()
        // 歌番号1, 2, 3の選択を外す
        let newState100 = settings.state100
                            .cancelInNumbers([1, 2, 3])
        settings.state100 = newState100
        // when
        let screen = DigitsPickerScreen01(settings: settings)
        screen.loadViewIfNeeded()
        // then
        XCTAssertEqual(badgeView(of: screen)?.text, "97首")
        let thirdCell = cellFor(screen, row: 2)
        XCTAssertEqual(thirdCell.selectedState, .partial)
    }
    
    func test_tapPartialMakesFull() {
        // given
        let settings = Settings()
        let newState100 =         settings.state100.cancelOf(number: 3)
        settings.state100 = newState100
        // when
        let screen = DigitsPickerScreen01(settings: settings)
        screen.loadViewIfNeeded()
        let thirdCell = cellFor(screen, row: 2)
        // then
        XCTAssertEqual(thirdCell.selectedState, .partial)
        // when
        tapCellOf(row: 2, in: screen)
        // then
        let newThirdCell = cellFor(screen, row: 2)
        XCTAssertEqual(newThirdCell.selectedState, .full)
    }
    
    func test_FullMakessEmpty() {
        // given
        let screen = DigitsPickerScreen01()
        // when
        screen.loadViewIfNeeded()
        // then
        let thirdCell = cellFor(screen, row: 2)
        XCTAssertEqual(thirdCell.selectedState, .full)
        // when
        tapCellOf(row: 2, in: screen)
        // then
        let newThirdCell = cellFor(screen, row: 2)
        XCTAssertEqual(newThirdCell.selectedState, .empry)
        XCTAssertEqual(badgeView(of: screen)?.text, "90首")
    }
    
    private func cellFor(_ screen: DigitsPickerScreen01, row: Int) -> SelectByGroupCell {
        screen.cellIn1stSection(row: row) as! SelectByGroupCell
    }
    
    private func tapCellOf(row: Int, in screen: DigitsPickerScreen01) {
        let indexPath = IndexPath(row: row, section: 0)
        screen.tableView(screen.tableView, didSelectRowAt: indexPath)
    }
}

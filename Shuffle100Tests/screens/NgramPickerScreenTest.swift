//
//  NgramPickerScreenTest.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2020/05/08.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest
@testable import Shuffle100

class NgramPickerScreenTest: XCTestCase, ApplyListContentConfiguration, SelectedNumBadgeTest {

    func test_initialScreen() throws {
        // given
        let screen = NgramPickerScreen()
        // when
        screen.loadViewIfNeeded()
        // then
        XCTAssertEqual(screen.title, "1字目で選ぶ")
        XCTAssertNotNil(screen.tableView)
        let buttonItem = screen.navigationItem.rightBarButtonItems?.last as? UIBarButtonItem
        XCTAssertNotNil(buttonItem)
        XCTAssertEqual(badgeView(of: screen)?.text, "100首")

    }
    
    func test_loadDataSourceFile() {
        // given
        let screen = NgramPickerScreen()
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
        let cellOfTopIn2CharsGroup = cellFor(screen, section: 1, row: 0)
        let content = listContentConfig(of: cellOfTopIn2CharsGroup)
        XCTAssertEqual(content.text, "「う」で始まる歌")
        XCTAssertNotNil(content.image)
        XCTAssertEqual(cellOfTopIn2CharsGroup.selectedState, .full)
    }
    
    func test_partialSelected() {
        // given
        let settings = Settings()
        let newState100 = settings.state100.cancelOf(number: 13) // 「つくばねの」を選択から外す
        settings.state100 = newState100
        // when
        let screen = NgramPickerScreen(settings: settings)
        screen.loadViewIfNeeded()
        // then
        XCTAssertEqual(badgeView(of: screen)?.text, "99首")

        let tsuCell = screen.selectByGroupCell(path: tsuIndexPath)
        let content = listContentConfig(of: tsuCell)
        XCTAssertEqual(content.text, "「つ」で始まる歌")
        XCTAssertEqual(tsuCell.selectedState, .partial)
    }
    
    func test_tapPartialMakesFull() {
        // given
        let settings = Settings()
        let newState100 =         settings.state100.cancelOf(number: 13) // 「つくばねの」を選択から外す
        settings.state100 = newState100
        // when
        let screen = NgramPickerScreen(settings: settings)
        screen.loadViewIfNeeded()
        let tsuCell = screen.selectByGroupCell(path: tsuIndexPath)
        // then
        XCTAssertEqual(tsuCell.selectedState, .partial)
        // when
        tapCellOfIndex(tsuIndexPath, in: screen)
        // then
        let newTsuCell = screen.selectByGroupCell(path: tsuIndexPath)
        XCTAssertEqual(newTsuCell.selectedState, .full)
        XCTAssertEqual(badgeView(of: screen)?.text, "100首")
    }
    
    func test_tapFullMakesEmpty() {
        // given
        let screen = NgramPickerScreen()
        screen.loadViewIfNeeded()
        let tsuCell = screen.selectByGroupCell(path: tsuIndexPath)
        XCTAssertEqual(tsuCell.selectedState, .full)
        // when
        tapCellOfIndex(tsuIndexPath, in: screen)
        // then
        let newTsuCell = screen.selectByGroupCell(path: tsuIndexPath)
        XCTAssertEqual(newTsuCell.selectedState, .empry)
        XCTAssertEqual(badgeView(of: screen)?.text, "98首")

    }
    
    private func cellFor(_ screen: NgramPickerScreen, section: Int, row: Int) -> SelectByGroupCell {
        screen.selectByGroupCell(
            path: IndexPath(row: row, section: section))
    }
    
    private var tsuIndexPath: IndexPath {
        IndexPath(row: 1, section: 1)
    }
    
    private func tapCellOfIndex(_ indexPath: IndexPath, in screen: NgramPickerScreen) {
        screen.tableView(screen.tableView, didSelectRowAt: indexPath)
    }
}

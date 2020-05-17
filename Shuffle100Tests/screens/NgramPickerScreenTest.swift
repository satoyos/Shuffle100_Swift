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
        let cellOfTopIn2CharsGroup = cellFor(screen, section: 1, row: 0)
        XCTAssertEqual(cellOfTopIn2CharsGroup.textLabel?.text, "「う」で始まる歌")
        XCTAssertNotNil(cellOfTopIn2CharsGroup.imageView?.image)
        XCTAssertEqual(cellOfTopIn2CharsGroup.selectedStatus, .full)
    }
    
    func test_partialSelected() {
        // given
        let settings = Settings()
        settings.state100.cancelOf(number: 13) // 「つくばねの」を選択から外す
        // when
        let screen = NgramPickerViewController(settings: settings)
        screen.loadViewIfNeeded()
        // then
        XCTAssertEqual(screen.badgeItem.badgeValue , "99首")
        let tsuIndex = tsuIndexPath()
        let tsuCell = cellFor(screen, section:tsuIndex.section, row: tsuIndex.row)
        XCTAssertEqual(tsuCell.textLabel?.text, "「つ」で始まる歌")
        XCTAssertEqual(tsuCell.selectedStatus, .partial)
    }
    
    func test_tapPartialMakesFull() {
        // given
        let settings = Settings()
        settings.state100.cancelOf(number: 13) // 「つくばねの」を選択から外す
        let screen = NgramPickerViewController(settings: settings)
        screen.loadViewIfNeeded()
        let tsuIndex = tsuIndexPath()
        let tsuCell = cellFor(screen, indexPath: tsuIndex)
        XCTAssertEqual(tsuCell.selectedStatus, .partial)
        // when
        tapCellOfIndex(tsuIndexPath(), in: screen)
        // then
        let newTsuCell = cellFor(screen, indexPath: tsuIndex)
        XCTAssertEqual(newTsuCell.selectedStatus, .full)
        XCTAssertEqual(screen.badgeItem.badgeValue, "100首")
    }
    
    func test_tapFullMakesEmpty() {
        // given
        let screen = NgramPickerViewController()
        screen.loadViewIfNeeded()
        let tsuIndex = tsuIndexPath()
        let tsuCell = cellFor(screen, indexPath: tsuIndex)
        XCTAssertEqual(tsuCell.selectedStatus, .full)
        // when
        tapCellOfIndex(tsuIndex, in: screen)
        // then
        let newTsuCell = cellFor(screen, indexPath: tsuIndex)
        XCTAssertEqual(newTsuCell.selectedStatus, .empry)
        XCTAssertEqual(screen.badgeItem.badgeValue, "98首")
    }
    
    private func cellFor(_ screen: NgramPickerViewController, section: Int, row: Int) -> NgramPickerTableCell {
        let cell = screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: row, section: section))
        return cell as! NgramPickerTableCell
    }
    
    private func cellFor(_ screen: NgramPickerViewController, indexPath: IndexPath) -> NgramPickerTableCell {
        let cell = screen.tableView(screen.tableView, cellForRowAt: indexPath)
        return cell as! NgramPickerTableCell
    }
    
    private func tsuIndexPath() -> IndexPath {
        return IndexPath(row: 1, section: 1)
    }
    
    private func tapCellOfIndex(_ indexPath: IndexPath, in screen: NgramPickerViewController) {
        screen.tableView(screen.tableView, didSelectRowAt: indexPath)
    }
}

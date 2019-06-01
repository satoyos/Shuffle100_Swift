//
//  HomeScreenDefaultTest.swift
//  Shuffle100Tests
//
//  Created by 里 佳史 on 2019/03/04.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest
@testable import Shuffle100

extension HomeScreenTest {
    func test_InitialHomeScreenHas_TOP_titleAndWhiteBackgroudView() {
        // given
        let screen = HomeViewController()
        // when
        screen.loadViewIfNeeded()
        // then
        XCTAssertEqual(screen.navigationItem.title, "トップ")
        XCTAssertEqual(screen.view.backgroundColor, UIColor.white)
    }
    
    func test_allCellsHaveAccessibilityLabel() {
        // given
        let screen = HomeViewController()
        // when
        screen.loadViewIfNeeded()
        // then
        let cell_top = selectedPoemsCell(of: screen)
        XCTAssertEqual(cell_top.accessibilityLabel, "poemsCell")
        let cell_2nd = screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: 1, section: 0))
        XCTAssertEqual(cell_2nd.accessibilityLabel, "reciteModeCell")
        let cell_startGame = startGameCell(of: screen)
        XCTAssertEqual(cell_startGame.accessibilityLabel, "GameStartCell")
    }
    
    func test_startGameCellTextIsRed() {
        // given
        let screen = HomeViewController()
        // when
        screen.loadViewIfNeeded()
        let cell_startGame = startGameCell(of: screen)
        // then
        XCTAssertEqual(cell_startGame.textLabel?.textColor, UIColor.red)
    }
    
    func test_startGameCellStyleIsDefault() {
        // given
        let screen = HomeViewController()
        // when
        screen.loadViewIfNeeded()
        let cell_startGame = startGameCell(of: screen)
        // then
        XCTAssertEqual(cell_startGame.cellStyle, UITableViewCell.CellStyle.default)
    }
    
    func test_fakeModeCellHasSwitch_defaultIsOff() {
        // given
        let screen = HomeViewController()
        // when
        screen.loadViewIfNeeded()
        let fakeModeCell = screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: 2, section: 0))
        // then
        guard let switchView = fakeModeCell.accessoryView as? UISwitch else {
            XCTAssert(false)
            return
        }
        XCTAssertFalse(switchView.isOn)
        XCTAssertEqual(switchView.accessibilityLabel, "fakeModeSwitch")
    }
    
    func test_defaultReciteModeIsNormal() {
        // given
        let screen = HomeViewController()
        // when
        let defaultReciteMode = screen.settings.reciteMode
        // then
        XCTAssertEqual(defaultReciteMode, .normal)
    }
    
    func test_defaultReciteModeLabelIsNormal() {
        // given
        let screen = HomeViewController()
        // when
        screen.loadViewIfNeeded()
        let reciteModeCell = screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: 1, section: 0))
        // then
        XCTAssertEqual(reciteModeCell.detailTextLabel?.text, "通常")
    }
    
    func test_defaultSelectedPoemsNumberIs100() {
        // given
        let screen = HomeViewController()
        // when
        screen.loadViewIfNeeded()
        // then
        XCTAssertEqual(selectedPoemsCell(of: screen).detailTextLabel?.text, "100首")
    }
    
    private func selectedPoemsCell(of screen: HomeViewController) -> HomeScreenTableCell {
        return screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! HomeScreenTableCell
    }
}

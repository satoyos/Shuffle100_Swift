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
        let screen = HomeScreen()
        // when
        screen.loadViewIfNeeded()
        // then
        XCTAssertEqual(screen.navigationItem.title, "トップ")
        XCTAssertEqual(screen.view.backgroundColor, UIColor.white)
    }
    
    func test_allCellsHaveAccessibilityLabel() {
        // given
        let screen = HomeScreen()
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
        let screen = HomeScreen()
        // when
        screen.loadViewIfNeeded()
        let cell_startGame = startGameCell(of: screen)
        // then
        guard let config = cell_startGame.contentConfiguration as? UIListContentConfiguration else {
            XCTFail("contentConfiguration should be set as UIListContentConfiguration!")
            return
        }
        XCTAssertEqual(config.textProperties.color, .systemRed)
    }
    
    func test_fakeModeCellHasSwitch_defaultIsOff() {
        // given
        let screen = HomeScreen()
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
        let screen = HomeScreen()
        // when
        let defaultReciteMode = screen.settings.reciteMode
        // then
        XCTAssertEqual(defaultReciteMode, .normal)
    }
    
    func test_defaultReciteModeLabelIsNormal() {
        // given
        let screen = HomeScreen()
        // when
        screen.loadViewIfNeeded()
        let reciteModeCell = screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: 1, section: 0))
        // then
        guard let conifg = reciteModeCell.contentConfiguration as? UIListContentConfiguration else {
            XCTAssert(false, "reciteModeCell.contentConfiguration should be set!")
            return
        }
        XCTAssertEqual(conifg.secondaryText, "通常")
    }
    
    func test_defaultSelectedPoemsNumberIs100() {
        // given
        let screen = HomeScreen()
        // when
        screen.loadViewIfNeeded()
        // then
        guard let config = selectedPoemsCell(of: screen).contentConfiguration as? UIListContentConfiguration else {                XCTAssert(false, "selectedPoemsCell.contentConfiguration should be set!")
            return
        }
        XCTAssertEqual(config.secondaryText, "100首")
    }
    
    private func selectedPoemsCell(of screen: HomeScreen) -> SettingTableCell {
        return screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! SettingTableCell
    }
}

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
        XCTAssertEqual(screen.navigationItem.title, "トップ")
        XCTAssertEqual(screen.view.backgroundColor, UIColor.white)
    }
    
    func test_allCellsHaveAccessibilityLabel() {
        let cell_top = selectedPoemsCell()
        XCTAssertEqual(cell_top.accessibilityLabel, "poemsCell")
        
        let cell_2nd = screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: 1, section: 0))
        XCTAssertEqual(cell_2nd.accessibilityLabel, "reciteModeCell")
        
        let cell_startGame = startGameCell()
        XCTAssertEqual(cell_startGame.accessibilityLabel, "GameStartCell")
    }
    
    func test_startGameCellTextIsRed() {
        let cell_startGame = startGameCell()
        XCTAssertEqual(cell_startGame.textLabel?.textColor, UIColor.red)
    }
    
    func test_startGameCellStyleIsDefault() {
        let cell_startGame = startGameCell()
        XCTAssertEqual(cell_startGame.cellStyle, UITableViewCell.CellStyle.default)
    }
    
    func test_fakeModeCellHasSwitch_defaultIsOff() {
        let fakeModeCell = screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: 2, section: 0))
        guard let switchView = fakeModeCell.accessoryView as? UISwitch else {
            XCTAssert(false)
            return
        }
        XCTAssertFalse(switchView.isOn)
    }
    
    func test_defaultReciteModeIsNormal() {
        let defaultReciteMode = screen.gameSettings.reciteMode
        XCTAssertEqual(defaultReciteMode, .normal)
    }
    
    func test_defaultReciteModeLabelIsNormal() {
        let reciteModeCell = screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: 1, section: 0))
        XCTAssertEqual(reciteModeCell.detailTextLabel?.text, "通常")
    }
    
    func test_defaultSelectedPoemsNumberIs100() {
        XCTAssertEqual(selectedPoemsCell().detailTextLabel?.text, "100首")
    }
    
    private func selectedPoemsCell() -> HomeScreenTableCell {
        return screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! HomeScreenTableCell
    }
}

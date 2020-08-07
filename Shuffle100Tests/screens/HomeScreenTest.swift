//
//  Shuffle100Tests.swift
//  Shuffle100Tests
//
//  Created by 里 佳史 on 2018/09/08.
//  Copyright © 2018年 里 佳史. All rights reserved.
//

import XCTest
@testable import Shuffle100

class HomeScreenTest: XCTestCase {
    internal func startGameCell(of screen: HomeViewController) ->        GameStartCell {
        var gameStartCellIndex = 0
        if screen.settings.reciteMode == .normal {
            gameStartCellIndex = 1
        }
        return screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: gameStartCellIndex, section: 1)) as! GameStartCell
    }
    
    func test_beginnerModeLabelIsBeginner() {
        // given
        let screen = HomeViewController(settings: beginnerSettings())
        
        // when
        screen.loadViewIfNeeded()
        let reciteModeCell = screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: 1, section: 0))
        
        //then
        XCTAssertEqual(reciteModeCell.detailTextLabel?.text, "初心者")
    }
    
    func test_fakeModeCellGetsHidden_inBeginnerMode() {
        // given
        let beginnerModeScreen = HomeViewController(settings: beginnerSettings())
        // when
        beginnerModeScreen.loadViewIfNeeded()
        // then
        let rowNum = beginnerModeScreen.tableView(beginnerModeScreen.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(rowNum, 3)
    }
    
    func test_changeReciteModeInSettings_reclectsModeLabel() {
        // given
        let screen = HomeViewController()
        screen.settings = beginnerSettings()
        // when
        screen.loadViewIfNeeded()
        screen.viewWillAppear(false)
        // then
        let reciteModeCell = screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: 1, section: 0))
        XCTAssertEqual(reciteModeCell.detailTextLabel?.text, "初心者")
    }
    
    func test_fakeModeIsOn_whenSetSoInGivenSettings() {
        // given
        let screen = HomeViewController()
        let settingsWithFakeModeOn = GameConfig(fakeMode: true)
        // when
        screen.settings = Settings(mode: settingsWithFakeModeOn)
        screen.loadViewIfNeeded()
        screen.viewWillAppear(false)        
        // then
        let fakeModeCell = screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: 2, section: 0))
        guard let switchView = fakeModeCell.accessoryView as? UISwitch else {
            XCTAssert(false)
            return
        }
        XCTAssertTrue(switchView.isOn)
    }
    
    func test_memorizeTimerCellExists() {
        // given
        let screen = HomeViewController()
        // when
        screen.loadViewIfNeeded()
        // then
        let cell = screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: 0, section: 1))
        XCTAssertEqual(cell.textLabel?.text, "暗記時間タイマー")
        
    }
    
    private func beginnerSettings() -> Settings {
        return Settings(mode: GameConfig(reciteMode: .beginner))
    }
}

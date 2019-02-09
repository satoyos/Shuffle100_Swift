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
    var screen: HomeViewController!
    
    override func setUp() {
        super.setUp()
        self.screen = HomeViewController()
        screen.viewDidLoad()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_InitialHomeScreen() {
        XCTAssertEqual(screen.navigationItem.title, "トップ")
        XCTAssertEqual(screen.view.backgroundColor, UIColor.white)
    }
    
    fileprivate func startGameCell() -> GameStartCell {
        return screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: 0, section: 1)) as! GameStartCell
    }
    
    func test_allCellsHaveAccessibilityLabel() {
        let cell_top = screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
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
   
    func test_fakeModeCellHasSwitch() {
        let fakeModeCell = screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: 2, section: 0))
        XCTAssertNotNil(fakeModeCell.accessoryView)
    }
    
    func test_defaultReciteModeIsNormal() {
        let defaultReciteMode = screen.gameSettings.reciteMode
        XCTAssertEqual(defaultReciteMode, .normal)
    }

    func test_defaultReciteModeLabelIsNormal() {
        let reciteModeCell = screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: 1, section: 0))
        XCTAssertEqual(reciteModeCell.detailTextLabel?.text, "通常")
    }
    
    func test_beginnerModeLabelIsBeginner() {
        // given
        let beginnerModeScreen = HomeViewController(gameSettings: GameSettings(reciteMode: .beginner))
        beginnerModeScreen.viewDidLoad()
        
        // when
        let reciteModeCell = beginnerModeScreen.tableView(screen.tableView, cellForRowAt: IndexPath(row: 1, section: 0))
        
        //then
        XCTAssertEqual(reciteModeCell.detailTextLabel?.text, "初心者")
    }
}

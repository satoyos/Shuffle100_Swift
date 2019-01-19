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
    
    func test_allCellsHaveAccessibilityLabel() {
        let cell_top = screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell_top.accessibilityLabel, "poemsCell")
        
        let cell_2nd = screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: 1, section: 0))
        XCTAssertEqual(cell_2nd.accessibilityLabel, "reciteModeCell")
        
        let cell_startGame = screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: 0, section: 1))
        XCTAssertEqual(cell_startGame.accessibilityLabel, "startGameCell")
    }
    
}

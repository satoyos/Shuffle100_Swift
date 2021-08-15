//
//  HomeScreenUITest.swift
//  Shuffle100UITests
//
//  Created by 里 佳史 on 2018/09/16.
//  Copyright © 2018年 里 佳史. All rights reserved.
//

import XCTest

class HomeScreenUITest: XCTestCase {
    let app = XCUIApplication()
    lazy var homePage = HomePage(app: app)
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchEnvironment = ["IS_TESTING" : "1"]
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_defaultCellsAndButtonsExistOnLoad() {
        correctLabelAndCellsExist()
        navBarButtonsExists()
    }
    
    private func correctLabelAndCellsExist() {
        XCTAssert(homePage.exists)
        XCTAssert(homePage.poemsCell.exists)
        XCTAssert(homePage.reciteModeCell.exists)
        XCTAssert(homePage.fakeModeCell.exists)
        XCTAssert(homePage.singerCell.exists)
    }
    
    private func navBarButtonsExists() {
        XCTAssert(homePage.gearButton.exists)
        XCTAssert(homePage.helpButton.exists)
    }
}

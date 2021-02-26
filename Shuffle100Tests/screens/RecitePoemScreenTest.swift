//
//  RecitePoemScreenTest.swift
//  Shuffle100Tests
//
//  Created by 里 佳史 on 2019/06/08.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest
@testable import Shuffle100

class RecitePoemScreenTest: XCTestCase {
    var screen = RecitePoemScreen()

    override func setUp() {
        screen.loadViewIfNeeded()
        screen.view.layoutIfNeeded()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_screenHasGameSettings() {
        XCTAssertNotNil(screen.settings)
    }
    
    func test_screenHasSinger() {
        XCTAssertNotNil(screen.singer)
    }
    
    func test_initialLayout() {
        XCTAssertEqual(screen.view.backgroundColor, StandardColor.barTintColor)
    XCTAssertEqual(screen.recitePoemView.headerContainer.backgroundColor, StandardColor.barTintColor)
    XCTAssertEqual(screen.recitePoemView.headerContainer.frame.size.height, 40)
    XCTAssertGreaterThan(screen.recitePoemView.playButton.frame.size.width, 100)
    }
    
    func test_playButtonAccessibilityIdentifier() {
        // when
        screen.recitePoemView.showAsWaitingFor(.pause)
        // then
        XCTAssertEqual(screen.recitePoemView.playButton.accessibilityIdentifier, "waitingForPause")
    }
    
    func test_playNumberedPoemCauseNoError() {
        XCTAssertNoThrow(screen.playNumberedPoem(number: 1, side: .shimo, count: 1))
    }
    
    func test_stepIntoNextPoemFlipView() {
        // given
        screen.recitePoemView.initView(title: "aaa")
        let supplier = PoemSupplier()
        // when
        let poem = supplier.drawNextPoem()!
        screen.stepIntoNextPoem(number: poem.number, at: supplier.currentIndex, total: supplier.size )
        sleep(1)
        // then
        XCTAssertEqual(screen.recitePoemView.headerTitle, "1首め:上の句 (全100首)")
        
    }
    
    func test_postmotermButtonExistsIfPostMortemEnabled() {
        // given
        let newSettings = Settings()
        newSettings.postMortemEnabled = true
        screen.settings = newSettings
        // when
        screen.stepIntoGameEnd()
        // then
        let gameEndView = screen.gameEndView
        XCTAssertNotNil(gameEndView)
        XCTContext.runActivity(named: "その画面には、ホーム画面に戻るボタンと、感想戦を始めるボタンがある") { _ in
            XCTAssertNotNil(gameEndView?.backToHomeButton)
//            XCTAssertNotNil(gameEndView?.postMortemButton)
        }
    }
}

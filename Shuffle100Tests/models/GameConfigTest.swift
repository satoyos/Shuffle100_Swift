//
//  GameConfigTest.swift
//  Shuffle100Tests
//
//  Created by 里 佳史 on 2019/02/09.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest
@testable import Shuffle100

class GameConfigTest: XCTestCase {

    func test_initWithoutParameters() {
        let settings = Settings()
        XCTAssertEqual(settings.reciteMode, .normal)
        XCTAssertFalse(settings.fakeMode)
        XCTAssertEqual(settings.state100.bools, Bool100.allSelected)
        XCTAssertEqual(settings.singerID, "ia")
        XCTAssertEqual(settings.postMortemEnabled, false)
        XCTAssertEqual(settings.shortenJoka, false)
    }
    
    func test_initWithRecoteModeParameter() {
        let modeSettings = GameConfig(reciteMode: .nonstop)
        let settings = Settings(mode: modeSettings)
        XCTAssertEqual(settings.reciteMode, .nonstop)
    }
    
    func test_initWithFakeModeParameter() {
        let modeSettings = GameConfig(fakeMode: true)
        let settings = Settings(mode: modeSettings)
        XCTAssertTrue(settings.fakeMode)
    }
    
    func test_repeatEnabledIsFalseByDefault() {
        let modeSettings = GameConfig()
        XCTAssertFalse(modeSettings.postMortemEnabled!)
    }
    
    func test_setRepeatEnableViaSettings() {
        // given
        let settings = Settings()
        // when
        settings.postMortemEnabled = true
        // then
        XCTAssert(settings.postMortemEnabled)
    }
}

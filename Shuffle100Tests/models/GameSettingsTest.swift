//
//  GameSettingsTest.swift
//  Shuffle100Tests
//
//  Created by 里 佳史 on 2019/02/09.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest
@testable import Shuffle100

class GameSettingsTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_initWithoutParameters() {
        let settings = Settings()
        XCTAssertEqual(settings.reciteMode, .normal)
        XCTAssertFalse(settings.fakeMode)
        let allSelectedBools100 = [Bool](repeating: true, count: 100)
        XCTAssertEqual(settings.selectedStatus100.bools, allSelectedBools100)
    }
    
    func test_initWithRecoteModeParameter() {
        let modeSettings = GameSettings(reciteMode: .nonstop)
        let settings = Settings(mode: modeSettings)
        XCTAssertEqual(settings.reciteMode, .nonstop)
    }
    
    func test_initWithFakeModeParameter() {
        let modeSettings = GameSettings(fakeMode: true)
        let settings = Settings(mode: modeSettings)
        XCTAssertTrue(settings.fakeMode)
    }

    //// これからどんどんGameSettingsをSettingsで置き換えていく！
    //// GameSettingsは、Settingsの初期化と永続化にしか使わないようにし、
    //// それらとテスト以外のコードには存在を隠蔽する。
    
    //// このテスト内はこれでOK。
    //// HomeScreenとSelectModeScreenも置き換え済み。
    //// 残るは、PoemPickerScreenのProductionコードだ！
    
}

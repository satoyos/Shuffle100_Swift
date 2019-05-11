//
//  SelectModeScreenTest.swift
//  Shuffle100Tests
//
//  Created by 里 佳史 on 2019/02/09.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest
@testable import Shuffle100

class SelectModeScreenTest: XCTestCase {
    func test_topPromptExists() {
        // given
        let screen = SelectModeViewController()
        // when
        screen.loadViewIfNeeded()
        // then
        XCTAssertEqual(screen.navigationItem.prompt, "百首読み上げ")
    }
    
    func test_pickerRowsCountIs3() {
        // given
        let screen = SelectModeViewController()
        // when
        let rowNum = screen.pickerView(screen.picker, numberOfRowsInComponent: 0)
        // then
        XCTAssertEqual(rowNum, 3)
    }

    func test_deaultSelectedRowIs0() {
        // given
        let screen = SelectModeViewController()
        // when
        let selected = screen.picker.selectedRow(inComponent: 0)
        // then
        XCTAssertEqual(selected, 0)
    }

    func test_beginnerModeIsSelected_whenSetSoInGameConfig() {
        // given
        let gameConfigWithBeginnerMode = GameConfig(reciteMode: .beginner)
        let screenB = SelectModeViewController(settings: Settings(mode: gameConfigWithBeginnerMode))
        // when
        screenB.viewDidLoad()
        let selected = screenB.picker.selectedRow(inComponent: 0)
        // then
        XCTAssertEqual(selected, 1)
    }
    
    func test_selectingModeOnPicker_changesGameConfig() {
        // given
        let screen = SelectModeViewController()
        // when: screenにイベントを送る
        screen.pickerView(screen.picker, didSelectRow: 1, inComponent: 0)
        // then
        XCTAssertEqual(screen.settings.reciteMode, .beginner)
    }

}

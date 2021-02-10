//
//  ReciteSettingsScreenTest.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2020/03/01.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest
@testable import Shuffle100

class ReciteSettingsScreenTest: XCTestCase, ApplyListContentConfiguration {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_initialScreen() {
        // given, when
        let screen = ReciteSettingsScreen()
        // then
        XCTAssertNotNil(screen)
        // when
        screen.loadViewIfNeeded()
        // then
        XCTAssertEqual(screen.title, "いろいろな設定")
        // then
        let tableView = screen.tableView
        XCTAssertNotNil(tableView)
        
        // 一旦、感想戦モードの実装開始
        XCTAssertEqual(screen.tableView(tableView!, numberOfRowsInSection: 0), 4)
//        XCTAssertEqual(screen.tableView(tableView!, numberOfRowsInSection: 0), 3)

        let firstCell = screen.tableView(tableView!, cellForRowAt: IndexPath(row: 0, section: 0))
        let firstConfig = listContentConfig(of: firstCell)
        XCTAssertEqual(firstConfig.text, "歌と歌の間隔")
        XCTAssertEqual(firstConfig.secondaryText, "1.10")
        let secondCell = screen.tableView(tableView!, cellForRowAt: IndexPath(row: 1, section: 0))
        let secondConfig = listContentConfig(of: secondCell)
        XCTAssertEqual(secondConfig.secondaryText, "1.00")
        let thirdCell = screen.tableView(tableView!, cellForRowAt: IndexPath(row: 2, section: 0))
        let thirdConfig = listContentConfig(of: thirdCell)
        XCTAssertEqual(thirdConfig.secondaryText, "100%")
    }

    // 感想戦モードの実装再開

    func test_fourthCellHasSwith() {
        // given
        let screen = ReciteSettingsScreen()
        // when
        screen.loadViewIfNeeded()
        // then
        let fourthCell = screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: 3, section: 0))
        XCTAssertNotNil(fourthCell)
        XCTAssertNotNil(fourthCell.accessoryView)
        XCTAssert(fourthCell.accessoryView!.isKind(of: UISwitch.self))
    }
    
    func test_switchInPostMortemCellReflectsSettings() {
        // given
        let screen = ReciteSettingsScreen()
        // when
        screen.settings.postMortemEnabled = true
        screen.loadViewIfNeeded()
        // then
        let pmSwitch = postMoremSwitch(in: screen)
        XCTAssert(pmSwitch.isOn)
    }
    
    func test_affectSettings() {
        // given
        let screen = ReciteSettingsScreen()
        // when
        screen.loadViewIfNeeded()
        // then
        let pmSwitch = postMoremSwitch(in: screen)
        XCTAssertFalse(pmSwitch.isOn)
        // when
        pmSwitch.setOn(true, animated: true)
        screen.switchValueChanged(sender: pmSwitch) // setOnだけではこのactionが呼ばれないので、明示的に呼ぶ
        // then
        XCTAssert(pmSwitch.isOn)
        XCTAssertEqual(screen.settings.postMortemEnabled, true)
    }
    
    private func postMoremSwitch(in screen: ReciteSettingsScreen) -> UISwitch {
        let fourthCell = screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: 3, section: 0))
        guard let pmSwitch = fourthCell.accessoryView as? UISwitch else {
            XCTFail("感想戦セルからUISwitchを取得できない！")
            return UISwitch()
        }
        return pmSwitch
    }
    
}

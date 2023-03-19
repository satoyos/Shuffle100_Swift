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
        guard let tableView = screen.tableView else {
            XCTFail("tableView property is nil on ReciteSettingsScreen")
            return
        }
        
        XCTAssertEqual(tableView.numberOfSections, 3)
        
        let firstSectionTitle = screen.tableView(tableView, titleForHeaderInSection: 0)
        XCTAssertEqual(firstSectionTitle, "読み上げの間隔")
        XCTAssertEqual(screen.tableView(tableView, numberOfRowsInSection: 0), 2)
        let firstCell = screen.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        let firstConfig = listContentConfig(of: firstCell)
        XCTAssertEqual(firstConfig.text, "歌と歌の間隔")
        XCTAssertEqual(firstConfig.secondaryText, "1.10"+"秒")
        let secondCell = screen.tableView(tableView, cellForRowAt: IndexPath(row: 1, section: 0))
        let secondConfig = listContentConfig(of: secondCell)
        XCTAssertEqual(secondConfig.secondaryText, "1.00"+"秒")
        let volumeCell = screen.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 1))
        let thirdConfig = listContentConfig(of: volumeCell)
        XCTAssertEqual(thirdConfig.secondaryText, "100%")
    }

    func test_shortenJokaCellHasSwith() {
        // given
        let screen = ReciteSettingsScreen()
        // when
        screen.loadViewIfNeeded()
        // then
        let shortenJokaCell = screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: 0, section: 2))
        XCTAssertNotNil(shortenJokaCell)
        XCTAssertNotNil(shortenJokaCell.accessoryView)
        XCTAssert(shortenJokaCell.accessoryView!.isKind(of: UISwitch.self))
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
    
    func test_postMortemSwitchAffectsSettings() {
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
    
    func test_switchInShortenJokaCellReflectsSettings() {
        // given
        let screen = ReciteSettingsScreen()
        // when
        screen.settings.shortenJoka = true
        screen.loadViewIfNeeded()
        // then
        let sjSwitch = shorenJokaSwitch(in: screen)
        XCTAssert(sjSwitch.isOn)
    }
    
    func test_shortenJokaSwitchAffectsSettings() {
        // given
        let screen = ReciteSettingsScreen()
        // when
        screen.loadViewIfNeeded()
        // then
        let sjSwitch = shorenJokaSwitch(in: screen)
        XCTAssertFalse(sjSwitch.isOn)
        // when
        sjSwitch.setOn(true, animated: true)
        screen.switchValueChanged(sender: sjSwitch) // setOnだけではこのactionが呼ばれないので、明示的に呼ぶ
        // then
        XCTAssert(sjSwitch.isOn)
        XCTAssertEqual(screen.settings.shortenJoka, true, "Settingsの中の設定値も書き換わっている")
    }
    
    private func postMoremSwitch(in screen: ReciteSettingsScreen) -> UISwitch {
        let fourthCell = screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: 1, section: 2))
        guard let pmSwitch = fourthCell.accessoryView as? UISwitch else {
            XCTFail("感想戦セルからUISwitchを取得できない！")
            return UISwitch()
        }
        return pmSwitch
    }
    
    private func shorenJokaSwitch(in screen: ReciteSettingsScreen) -> UISwitch {
        let fifthCell = screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: 0, section: 2))
        guard let sjSwitch = fifthCell.accessoryView as? UISwitch else {
            XCTFail("「序歌を短くする」セルからUISwitchを取得できない！")
            return UISwitch()
        }
        return sjSwitch
    }
}

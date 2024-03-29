//
//  FudaSetsScreenTest.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2020/05/25.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest
@testable import Shuffle100

class FudaSetsScreenTest: XCTestCase, ApplyListContentConfiguration {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_initialScreen() throws {
        // given, when
        let screen = FudaSetsScreen()
        // then
        XCTAssertNotNil(screen)
        // when
        screen.loadViewIfNeeded()
        // then
        XCTAssertEqual(screen.title, "作った札セットから選ぶ")
        XCTAssertNotNil(screen.tableView)
    }
    
    func test_eachCellShowsFudaSetSize() {
        // given
        let screen = FudaSetsScreen()
        screen.loadViewIfNeeded()
        // when
        let set = SavedFudaSet(name: "aaa", state100: SelectedState100.init(bool100: Bool100.allSelected))
        screen.settings.savedFudaSets.append(set)
        // then
        let cell = screen.tableView(screen.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        let content = listContentConfig(of: cell)
        XCTAssertEqual(content.text, "aaa")
        XCTAssertEqual(content.secondaryText, "100首")

    }
    
    func test_tapFudaSetCellChangesSelectedPoems() {
        // given
        var screen: FudaSetsScreen!
        let fullSelectedState = SelectedState100.createOf(bool: true)
        
        let partialySelectedState100 = selectedState97()
        XCTContext.runActivity(named: "デフォルトでは100首選ばれている") { _ in
            // when
            screen = FudaSetsScreen()
            // then
            XCTAssertEqual(screen.settings.state100, fullSelectedState)
            XCTAssertNotEqual(screen.settings.state100, partialySelectedState100)
        }
        XCTContext.runActivity(named: "3種だけのセットを選ぶと、settingsが保持する歌選択状態も上書きされる") { _ in
            // given
            let fudaSet = SavedFudaSet(name: "3首セット", state100: partialySelectedState100)
            screen.settings.savedFudaSets.append(fudaSet)
            XCTAssertEqual(screen.settings.savedFudaSets.count, 1)
            // when
            screen.loadViewIfNeeded()
            screen.tableView(screen.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
            // then
            XCTAssertEqual(screen.settings.state100, partialySelectedState100)
        }
    }
    
    private func selectedState97() -> SelectedState100 {
        var boolArray = Bool100.allUnselected
        boolArray[0] = true
        boolArray[1] = true
        boolArray[4] = true
        return SelectedState100(bool100: boolArray)
    }
    
    func test_deleteFudaSet() {
        // given
        let screen = FudaSetsScreen()
        let fudaSet = SavedFudaSet(name: "97枚セット", state100: selectedState97())
        screen.settings.savedFudaSets.append(fudaSet)
        // when
        screen.loadViewIfNeeded()
        // then
        let indexPath = IndexPath(row: 0, section: 0)
        XCTAssert(screen.tableView(screen.tableView, canEditRowAt: indexPath))
        // when
        screen.tableView(screen.tableView, commit: .delete, forRowAt: indexPath)
        // then
        XCTAssertEqual(screen.settings.savedFudaSets.count, 0)
    }
    
}

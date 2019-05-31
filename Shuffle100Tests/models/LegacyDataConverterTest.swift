//
//  LegacyDataConverterTest.swift
//  Shuffle100Tests
//
//  Created by 里 佳史 on 2019/05/29.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

class LegacyDataConverterTest: XCTestCase {

    func test_state100FromGameSettings() {
        // given
        var testBools = Bool100.allFalseBoolArray()
        for i in [2,3,5] {testBools[i] = true}
        let testSelectedStatus100 = SelectedStatus100(status: testBools)
        let testSettings = GameSettings(status100: testSelectedStatus100)
        // when
        let state100 = LegacyDataConverter.state100FromGameSettings(testSettings)
        // then
        XCTAssertEqual(state100.selectedNum, 3)
    }
    
    func test_savedFudaSetsFromGameSettings() {
        // given
        let testFudaSet1 = FudaSet(name: "セット1", status100: SelectedStatus100(status: Bool100.allTrueBoolArray()))
        let testFudaSet2 = FudaSet(name: "セット2", status100: SelectedStatus100(status: Bool100.allFalseBoolArray()))
        let testGameSettings = GameSettings(fuda_sets: [testFudaSet1, testFudaSet2])
        // when
        let testSets = LegacyDataConverter.savedFudaSetsFromGameSettings(testGameSettings)
        // then
        XCTAssertEqual(testSets.count, 2)
        let secondSet = testSets[1]
        XCTAssertEqual(secondSet.name, "セット2")
        XCTAssertEqual(secondSet.state100.selectedNum, 0)
        let firstSet = testSets[0]
        XCTAssertEqual(firstSet.state100.selectedNum, 100)        
    }
    
    func test_convertRecitingSettings() {
        // give
        let testSettings = RecitingSettings(volume: 0.1, interval: 0.2, kamiShimoInterval: 0.3)
        // when
        let config = LegacyDataConverter.convertRecitingSettings(testSettings)
        // then
        XCTAssertEqual(config.volume, 0.1)
        XCTAssertEqual(config.interval, 0.2)
        XCTAssertEqual(config.kamiShimoInterval, 0.3)
    }

}

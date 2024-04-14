//
//  SelectedState100Tests.swift
//  Poems
//
//  Created by 里 佳史 on 2017/04/30.
//  Copyright © 2017年 里 佳史. All rights reserved.
//

import XCTest
@testable import Shuffle100

class SelectedState100Tests: XCTestCase {
    let init_value = SelectedState100.defaultState
    
    func test_init_without_params() {
        let state100 = SelectedState100()
        XCTAssertNotNil(state100)
        // クラスで定義された初期値で初期化されている
        let bs = state100.bools
        XCTAssertEqual(bs.count, 100)
        XCTAssertEqual(bs[0], init_value)
        XCTAssertEqual(bs[15], init_value)
    }
    
    func test_initWithBool100() {
        // given
        var testBool100 = Bool100.allUnselected
        testBool100[3] = true
        testBool100[25] = true
        // when
        let state100 = SelectedState100(bool100: testBool100)
        // then
        XCTAssertNotNil(state100)
        XCTAssertEqual(state100.bools[0],  false)
        XCTAssertEqual(state100.bools[25], true)
    }
    
    func test_classMethod_createOfBool() {
        // 全てtrueで初期化
        let st100_t = SelectedState100.createOf(bool: true)
        XCTAssertNotNil(st100_t)
        XCTAssertEqual(st100_t.bools[0], true)
        
        // 全てfalseで初期化
        let st100_f = SelectedState100.createOf(bool: false)
        XCTAssertEqual(st100_f.bools[0], false)
    }
    
    
    func test_ofNumber() {
        var state100 = SelectedState100()
        // 添え字15の要素のみ、デフォルトの初期値と逆にする
        state100.bools[15] = !init_value
        // このメソッドでは、bools[]の添え字よりも1多い数のindexでアクセスする
        XCTAssertEqual(try state100.ofNumber(15), init_value)
        XCTAssertEqual(try state100.ofNumber(16), !init_value)
        
        // 添え字の範囲は1から100まで
        XCTAssertThrowsError(try state100.ofNumber(0))
        XCTAssertThrowsError(try state100.ofNumber(101))
    }
    
    func test_selectedNum() {
        // given
        let state100 = SelectedState100.createOf(bool: false)
        var newBools = state100.bools
        // when
        for i in [1,3,5] {newBools[i] = true}
        let newState100 = SelectedState100(bool100: newBools)
        XCTAssertEqual(newState100.selectedNum, 3)
    }
    
    func test_allSelectedNumbers() {
        // given
        var bool100 = Bool100.allUnselected
        bool100[1] = true
        bool100[2] = true
        bool100[10] = true
        let state100 = SelectedState100(bool100: bool100)
        // when
        let numbers = state100.allSelectedNumbers
        // then
        XCTAssertEqual(numbers, [2, 3, 11])
    }
}

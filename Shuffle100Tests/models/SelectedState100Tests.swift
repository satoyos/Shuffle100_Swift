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
    
    func test_setStatusOfNumber() {
        let state100 = SelectedState100()
        let idx = 15 // 1はじまりの番号
        XCTAssertEqual(try state100.ofNumber(idx),init_value)
        
        // 違う値を設定してみる
        guard let newState100 = try?  state100.setStateOfNumber(state: !init_value, index: idx) else {
            XCTFail("xxx this Error shuold not be thrown!")
            return
        }
        XCTAssertEqual(try newState100.ofNumber(idx), !init_value)
        // 一つ前の番号については、初期値通り
        XCTAssertEqual(try state100.ofNumber(idx-1), init_value)
    }

    func test_cancellAll() {
        // すべて「選択済み」(true)で初期化しておく
        let state100 = SelectedState100.createOf(bool: true)
        // 全キャンセルのメソッドを呼び出す
        let newState100 = state100.cancelAll()
        // 結果の確認
        for i in 1...100 {
            XCTAssertEqual(try newState100.ofNumber(i), false)
        }
    }
    
    func test_selectAll() {
        // 「選択なし」状態で初期化しておく
        let state100 = SelectedState100.createOf(bool: false)
        XCTAssertEqual(state100.bools[3], false)
        // 全選択のメソッドを呼び出す
        let newState100 = state100.selectAll()
        // 結果の確認
        for i in 1...100 {
            XCTAssertEqual(try newState100.ofNumber(i), true)
        }
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
    
    func test_selectOfNumber() {
        // 10番の要素だけを選択するようにする
        let state100 = SelectedState100.createOf(bool: false)
        XCTAssertEqual(try state100.ofNumber(10), false)
        
        // 10番目の要素を指定してselectOf()を呼ぶと、その要素だけがtrueに変わる。
        let newState100 = state100.selectOf(number: 10)
        XCTAssertEqual(try newState100.ofNumber(10), true)
        XCTAssertEqual(newState100.selectedNum, 1)
    }
    
    func test_cancelOfNumber() {
        // 全て選択(true)状態で初期化する
        let state100 = SelectedState100.createOf(bool: true)
        XCTAssertEqual(try state100.ofNumber(6), true)
        
        // 6番目の要素を指定してcancelOf()を呼ぶと、その要素だけがfalseに変わる
        let newState100 = state100.cancelOf(number: 6)
        XCTAssertEqual(try newState100.ofNumber(6), false)
        XCTAssertEqual(newState100.selectedNum, 99)
    }
    
    func test_selectInNumbers() {
        // 全て選択(false)状態で初期化する
        let state100 = SelectedState100.createOf(bool: false)
        // 選択したい要素を、1始まりの番号の配列で指定する
        let newState100 = state100.selectInNumbers([1, 5, 10])
        // then
        XCTAssertEqual(newState100.selectedNum, 3)
        XCTAssertEqual(try newState100.ofNumber(5), true)
    }
    
    func test_cancelInNumbers() {
        // 全てキャンセル(false)状態で初期化する
        let state100 = SelectedState100.createOf(bool: true)
        // キャンセルしたい要素を、1はじまりの番号の配列で指定する
        let newState100 = state100.cancelInNumbers([2, 4, 8, 16, 32, 64])
        XCTAssertEqual(try newState100.ofNumber(8), false)
        XCTAssertEqual(newState100.selectedNum, 94)
    }
    
    func test_reverse_in_index() {
        // given
        let state100 = SelectedState100.createOf(bool: true)
        // when
        let newState100 = state100.reverseInIndex(0)
        // then
        XCTAssertFalse(try! newState100.ofNumber(1))
    }
    
    func test_reverseInNumber() {
        // giben
        let state100 = SelectedState100.createOf(bool: true)
        // when
        let newState100 = state100.reverseInNumber(4)
        // then
        XCTAssertFalse(try! newState100.ofNumber(4))
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

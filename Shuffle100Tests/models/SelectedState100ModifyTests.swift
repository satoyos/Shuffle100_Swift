//
//  SelectedState100ModifyTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2024/04/14.
//  Copyright © 2024 里 佳史. All rights reserved.
//

@testable import Shuffle100
import XCTest

final class SelectedState100ModifyTests: XCTestCase {
    let init_value = SelectedState100.defaultState

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
}

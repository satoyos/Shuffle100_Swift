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
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_init_without_params() {
        let state100 = SelectedState100()
        XCTAssertNotNil(state100)
        // クラスで定義された初期値で初期化されている
        let bs = state100.bools
        XCTAssertEqual(bs.count, 100)
        XCTAssertEqual(bs[0], init_value)
        XCTAssertEqual(bs[15], init_value)
    }
    
    func test_initWithBoolArray() {
        // 添え字が3番と25番だけtrueで、あとは全部falseな配列(サイズは100)を作る
        var b_array: Array<Bool> = []
        for _ in 0..<100 {b_array.append(false)}
        b_array[3] = true
        b_array[25] = true

        let state100 = SelectedState100(array: b_array)
        XCTAssertNotNil(state100)
        
        // 正しく初期化されていることを確認！
        XCTAssertEqual(state100.bools[0],  false)
        XCTAssertEqual(state100.bools[25], true)
    }
    
    
    
    func test_classMethod_createOfBool() {
        // 全てtrueで初期化
        let st100_t = SelectedState100.create_of(bool: true)
        XCTAssertNotNil(st100_t)
        XCTAssertEqual(st100_t.bools[0], true)
        
        // 全てfalseで初期化
        let st100_f = SelectedState100.create_of(bool: false)
        XCTAssertEqual(st100_f.bools[0], false)
    }
    
    
    func test_ofNumber() {
        let state100 = SelectedState100()
        // 添え字15の要素のみ、デフォルトの初期値と逆にする
        state100.bools[15] = !init_value
        // このメソッドでは、bools[]の添え字よりも1多い数のindexでアクセスする
        XCTAssertEqual(try state100.of_number(15), init_value)
        XCTAssertEqual(try state100.of_number(16), !init_value)
        
        // 添え字の範囲は1から100まで
        XCTAssertThrowsError(try state100.of_number(0))
        XCTAssertThrowsError(try state100.of_number(101))
    }
    
    func test_setStatusOfNumber() {
        let state100 = SelectedState100()
        let idx = 15 // 1はじまりの番号
        XCTAssertEqual(try state100.of_number(idx),init_value)
        
        // 違う値を設定してみる
        do {
            try state100.set_state_of_number(state: !init_value, index: idx)
            XCTAssertEqual(try state100.of_number(idx), !init_value)
            // 一つ前の番号については、初期値通り
            XCTAssertEqual(try state100.of_number(idx-1), init_value)
        } catch {
            print("xxx this Error shuold not be thrown!")
        }
    }

    func test_cancellAll() {
        // すべて「選択済み」(true)で初期化しておく
        let state100 = SelectedState100.create_of(bool: true)
        
        // 全キャンセルのメソッドを呼び出す
        state100.cancel_all()
        
        // 結果の確認
        for i in 1...100 {
            XCTAssertEqual(try state100.of_number(i), false)
        }
    }
    
    func test_selectAll() {
        // 「選択なし」状態で初期化しておく
        let state100 = SelectedState100.create_of(bool: false)
        XCTAssertEqual(state100.bools[3], false)
        
        // 全選択のメソッドを呼び出す
        state100.select_all()
        
        // 結果の確認
        for i in 1...100 {
            XCTAssertEqual(try state100.of_number(i), true)
        }
    }

    func test_selectedNum() {
        let state100 = SelectedState100.create_of(bool: false)
        for i in [1,3,5] {state100.bools[i] = true}
        XCTAssertEqual(state100.selected_num, 3)
    }
    
    func test_select_of_number() {
        // 10番の要素だけを選択するようにする
        let state100 = SelectedState100.create_of(bool: false)
        XCTAssertEqual(try state100.of_number(10), false)
        
        // 10番目の要素を指定してselect_of()を呼ぶと、その要素だけがtrueに変わる。
        state100.select_of(number: 10)
        XCTAssertEqual(try state100.of_number(10), true)
        XCTAssertEqual(state100.selected_num, 1)
    }
    
    func test_cancel_of_number() {
        // 全て選択(true)状態で初期化する
        let state100 = SelectedState100.create_of(bool: true)
        XCTAssertEqual(try state100.of_number(6), true)
        
        // 6番目の要素を指定してcancel_of()を呼ぶと、その要素だけがfalseに変わる
        state100.cancel_of(number: 6)
        XCTAssertEqual(try state100.of_number(6), false)
        XCTAssertEqual(state100.selected_num, 99)
    }
    
    func test_select_in_numbers() {
        // 全て選択(false)状態で初期化する
        let state100 = SelectedState100.create_of(bool: false)

        // 選択したい要素を、1始まりの番号の配列で指定する
        state100.select_in_numbers([1, 5, 10])

        XCTAssertEqual(state100.selected_num, 3)
        XCTAssertEqual(try state100.of_number(5), true)
    }
    
    func test_cancel_in_numbers() {
        // 全てキャンセル(false)状態で初期化する
        let state100 = SelectedState100.create_of(bool: true)
        
        // キャンセルしたい要素を、1はじまりの番号の配列で指定する
        state100.cancel_in_numbers([2, 4, 8, 16, 32, 64])
        XCTAssertEqual(try state100.of_number(8), false)
        XCTAssertEqual(state100.selected_num, 94)
    }
}

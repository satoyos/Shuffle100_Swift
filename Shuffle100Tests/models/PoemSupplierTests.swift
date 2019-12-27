//
//  PoemSupplierTests.swift
//  Poems
//
//  Created by 里 佳史 on 2017/05/17.
//  Copyright © 2017年 里 佳史. All rights reserved.
//

import XCTest
@testable import Shuffle100

class PoemSupplierTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_initWithNoArg() {
        let supplier = PoemSupplier()
        XCTAssertNotNil(supplier)
        XCTAssertEqual(supplier.size, 100)
        XCTAssertEqual(supplier.current_index, 0)
    }
    
    func test_initWithArgs() {
        let supplier = PoemSupplier(deck: Deck(), shuffle: true)
        XCTAssertNotNil(supplier.deck)
        XCTAssertEqual(supplier.current_index, 0)
    }
    
//    func test_drawNextPoem() {
//        let supplier = PoemSupplier(deck: Deck(), shuffle: false)
//        XCTAssertEqual(supplier.current_index, 0)
//        // できたてのオブジェクトは、poemプロパティの値がnil
//        XCTAssertNil(supplier.poem)
//
//        // まだ次の歌があるとき、trueを返す
//        let bool = supplier.draw_next_poem()
//        XCTAssertTrue(bool)
//        XCTAssertEqual(supplier.current_index, 1)
//        XCTAssertEqual(supplier.poem.poet, "天智天皇")
//
//        // あと2回めくると、保持する歌の番号は3になる.
//        for _ in (1...2) {_ = supplier.draw_next_poem()}
//        XCTAssertEqual(supplier.current_index, 3)
//        XCTAssertEqual(supplier.poem.number, 3)
//
//        // あと97回は問題なくめくれる
//        for _ in (1...97) { _ = supplier.draw_next_poem() }
//        XCTAssertEqual(supplier.current_index, 100)
//
//        // もう次の歌が無いとき
//        // falseを返す
//        let bool2 = supplier.draw_next_poem()
//        XCTAssertFalse(bool2)
//        // current_indexは最後の札のまま変わっていない。
//        XCTAssertEqual(supplier.current_index, 100)
//    }
    
    func test_rollbackPrevPoem() {
        let supplier = PoemSupplier(deck: Deck(), shuffle: false)
        // 予め2枚めくっておく
        for _ in (1...2) { _ = supplier.drawNextPoem() }
        XCTAssertEqual(supplier.current_index, 2)
        
        // 1回ロールバックすると、current_indexおよび歌番号が1になる。
        let bool = supplier.rollback_prev_poem()
        XCTAssertTrue(bool)
        XCTAssertEqual(supplier.current_index, 1)
        XCTAssertEqual(supplier.poem.number, 1)
        
        // もう1回ロールバックすると、もう戻る歌が無いため、falseを返す
        let bool2 = supplier.rollback_prev_poem()
        XCTAssertFalse(bool2)
    }
    
    func test_stepIntoShimo() {
        let supplier = PoemSupplier()
        _ = supplier.drawNextPoem()
        XCTAssertTrue(supplier.kami_now)
        XCTAssertEqual(supplier.side, .kami)
        
        supplier.step_into_shimo()
        XCTAssertFalse(supplier.kami_now)
        XCTAssertEqual(supplier.side, .shimo)
    }
    
    func test_againstBugInRubyMotionEra() {
        // 1枚めくり、そこから巻き戻そうとすると、falseが返る
        let supplier = PoemSupplier()
        _ = supplier.drawNextPoem()
        let bool = supplier.rollback_prev_poem()
        XCTAssertFalse(bool)
        
        // このとき、poemプロパティの中身は空っぽ(nil)
        XCTAssertNil(supplier.poem)
    }
    
    func test_new_drawNextPoem() {
        // given
        let supplier = PoemSupplier()        
        // まだ次の歌があるとき、そのPoemを返す
        let first = supplier.drawNextPoem()
        XCTAssertNotNil(first)
        // あと98枚引く
        for _ in 1...98 {
            _ = supplier.drawNextPoem()
        }
        // 100枚目を引く
        let at100 = supplier.drawNextPoem()
        XCTAssertEqual(supplier.current_index, 100)
        XCTAssertNotNil(at100)
        // 100枚引いた状態で、もう1枚引く
        let after100 = supplier.drawNextPoem()
        XCTAssertNil(after100)
    }
}

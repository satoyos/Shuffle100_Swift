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

    func test_initWithNoArg() {
        let supplier = PoemSupplier()
        XCTAssertNotNil(supplier)
        XCTAssertEqual(supplier.size, 100)
        XCTAssertEqual(supplier.currentIndex, 0)
    }
    
    func test_initWithArgs() {
        let supplier = PoemSupplier(deck: Deck(), shuffle: true)
        XCTAssertNotNil(supplier.deck)
        XCTAssertEqual(supplier.currentIndex, 0)
    }
    
    func test_rollBackPrevPoem() {
        let supplier = PoemSupplier(deck: Deck(), shuffle: false)
        // 予め2枚めくっておく
        for _ in (1...2) { _ = supplier.drawNextPoem() }
        XCTAssertEqual(supplier.currentIndex, 2)
        
        // 1回ロールバックすると、currentIndexおよび歌番号が1になる。
        let poem = supplier.rollBackPrevPoem()
        XCTAssertNotNil(poem)
        XCTAssertEqual(supplier.currentIndex, 1)
        XCTAssertEqual(poem!.number, 1)
        XCTAssertEqual(supplier.poem.number, 1)
        
        // もう1回ロールバックすると、もう戻る歌がないため、nilを返す
        let poem2 = supplier.rollBackPrevPoem()
        XCTAssertNil(poem2)
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
        let poem = supplier.rollBackPrevPoem()
        XCTAssertNil(poem)
        
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
        XCTAssertEqual(supplier.currentIndex, 100)
        XCTAssertNotNil(at100)
        // 100枚引いた状態で、もう1枚引く
        let after100 = supplier.drawNextPoem()
        XCTAssertNil(after100)
    }
    
    func test_addFakePoems() {
        // given
        let bool100 = Bool100.allUnselected()
        let state100 = SelectedState100(bool100: bool100)
        state100.select_of(number: 3)
        state100.select_of(number: 5)
        let deck = Deck.createFrom(state100: state100)
        let supplier = PoemSupplier(deck: deck, shuffle: true)
        XCTAssertEqual(supplier.deck.size, 2)
        // when
        supplier.addFakePoems()
        // then
        XCTAssertEqual(supplier.deck.size, 4)
    }
}

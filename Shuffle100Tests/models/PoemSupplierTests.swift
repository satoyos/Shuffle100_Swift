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
        let supplier = PoemSupplier(deck: Poem100.originalPoems, shuffle: true)
//        XCTAssertNotNil(supplier.deck)
        XCTAssertEqual(supplier.currentIndex, 0)
    }
    
    func test_rollBackPrevPoem() {
        // given
        let supplier = PoemSupplier(deck: Poem100.originalPoems, shuffle: false)
        // when: 予め2枚めくっておく
        for _ in (1...2) { supplier.drawNextPoem() }
        // then
        XCTAssertEqual(supplier.currentIndex, 2)
        // 1回ロールバックすると、currentIndexおよび歌番号が1になる。
        // when
        let poem = supplier.rollBackPrevPoem()
        // then
        XCTAssertNotNil(poem)
        XCTAssertEqual(supplier.currentIndex, 1)
        XCTAssertEqual(poem!.number, 1)
        XCTAssertEqual(supplier.currentPoem?.number, 1)
        
        // もう1回ロールバックすると、もう戻る歌がないため、nilを返す
        let poem2 = supplier.rollBackPrevPoem()
        XCTAssertNil(poem2)
    }
    
    func test_stepIntoShimo() {
        let supplier = PoemSupplier()
        _ = supplier.drawNextPoem()
        XCTAssertTrue(supplier.kamiNow)
        XCTAssertEqual(supplier.side, .kami)
        
        supplier.stepIntoShimo()
        XCTAssertFalse(supplier.kamiNow)
        XCTAssertEqual(supplier.side, .shimo)
    }
    
    func test_againstBugInRubyMotionEra() {
        // 1枚めくり、そこから巻き戻そうとすると、falseが返る
        let supplier = PoemSupplier()
        supplier.drawNextPoem()
        let poem = supplier.rollBackPrevPoem()
        XCTAssertNil(poem)
        
        // このとき、poemプロパティの中身は空っぽ(nil)
        XCTAssertNil(supplier.currentPoem)
    }
    
    func test_drawNextPoem() {
        // given
        let supplier = PoemSupplier()
        // まだ次の歌があるとき、そのPoemを返す
        // when
        let first = supplier.drawNextPoem()
        // then
        XCTAssertNotNil(first)
        XCTAssertEqual(supplier.currentIndex, 1)
        // when: あと98枚引く
        for _ in 1...98 {
            supplier.drawNextPoem()
        }
        // and when: 100枚目を引く
        let at100 = supplier.drawNextPoem()
        // then
        XCTAssertEqual(supplier.currentIndex, 100)
        XCTAssertNotNil(at100)
        // when: 100枚引いた状態で、もう1枚引く
        let after100 = supplier.drawNextPoem()
        // then
        XCTAssertNil(after100)
    }
    
    func test_addFakePoems() {
        // given
        let state100 = SelectedState100.createOf(bool: false)
                        .selectOf(number: 3)
                        .selectOf(number: 5)
        let deck = Poem100.createFrom(state100: state100)
        let supplier = PoemSupplier(deck: deck, shuffle: true)
        XCTAssertEqual(supplier.size, 2)
        // when
        supplier.addFakePoems()
        // then
        XCTAssertEqual(supplier.size, 4)
    }
    
    func testEvenLargeDeckMustBeShuffledInFakeMode() {
        // given
        let state100 = SelectedState100.createOf(bool: true)
            .cancelOf(number: 100)
            .cancelOf(number: 99)
            .cancelOf(number: 98)
            .cancelOf(number: 97)
        let deck = Poem100.createFrom(state100: state100)
        let supplier = PoemSupplier(deck: deck, shuffle: true)
        XCTAssertEqual(supplier.size, 96)
        // when
        supplier.addFakePoems()
        // then
        let array1to100 = (1...100).map{$0}
        XCTAssertNotEqual(supplier.poemNumbers, array1to100, "deck must be shuffled!")
    }
    
    func test_shuffleWithSize() {
        // given
        let supplier = PoemSupplier()
        // when
        supplier.shuffleDeck(with: 10)
        // then
        XCTAssertEqual(supplier.size, 10)
        // when: 10枚めくる
        for _ in 1...10 {
            let poem = supplier.drawNextPoem()
            // then
            XCTAssertNotNil(poem)
        }
        // when: さらにもう1枚めくる
        let drawMore = supplier.drawNextPoem()
        // then
        XCTAssertNil(drawMore)
    }
    
    func test_resetCurrentIndex() {
        // given
        let supplier = PoemSupplier()
        // when
        XCTAssertEqual(supplier.currentIndex, 0)
        supplier.drawNextPoem()
        supplier.drawNextPoem()
        supplier.drawNextPoem()
        // then
        XCTAssertEqual(supplier.currentIndex, 3)
        // when
        supplier.resetCurrentIndex()
        // then
        XCTAssertEqual(supplier.currentIndex, 0)
    }
    
    
    func test_poemNumbers() {
        // given
        let st100 = SelectedState100.createOf(bool: false)
        let numbers = [25, 3, 17]
        let newState100 = st100.selectInNumbers(numbers)
        let deck = Poem100.createFrom(state100: newState100)
        let supplier = PoemSupplier(deck: deck, shuffle: true)
        // when
        let numbersFromDeck = supplier.poemNumbers
        // then
        XCTAssertEqual(numbers.sorted(), numbersFromDeck.sorted())
    }
}

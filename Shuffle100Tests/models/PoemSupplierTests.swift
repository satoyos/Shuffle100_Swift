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
        let supplier = PoemSupplier(deck: PoemSupplier.originalPoems, shuffle: true)
//        XCTAssertNotNil(supplier.deck)
        XCTAssertEqual(supplier.currentIndex, 0)
    }
    
    func test_rollBackPrevPoem() {
        // given
        let supplier = PoemSupplier(deck: PoemSupplier.originalPoems, shuffle: false)
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
        let deck = 
            SelectedState100.createOf(bool: false)
            .selectOf(number: 2)
            .selectOf(number: 5)
            .convertToDeck()
        //                        .selectOf(number: 3)
        //                        .selectOf(number: 5)
        let supplier = PoemSupplier(deck: deck, shuffle: true)
        XCTAssertEqual(supplier.size, 2)
        // when
        supplier.addFakePoems()
        // then
        XCTAssertEqual(supplier.size, 4)
    }
    
    func testEvenLargeDeckMustBeShuffledInFakeMode() {
        // given
        let deck = SelectedState100.createOf(bool: true)
            .cancelOf(number: 100)
            .cancelOf(number: 99)
            .cancelOf(number: 98)
            .cancelOf(number: 97)
            .convertToDeck()
        let supplier = PoemSupplier(deck: deck, shuffle: true)
        XCTAssertEqual(supplier.size, 96)
        // when
        supplier.addFakePoems()
        // then
        let array1to100 = (1...100).map{$0}
        XCTAssertNotEqual(supplier.poemNumbers, array1to100, "deck must be shuffled!")
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
        let deck = st100           .selectInNumbers(numbers)         .convertToDeck()
        let supplier = PoemSupplier(deck: deck, shuffle: true)
        // when
        let numbersFromDeck = supplier.poemNumbers
        // then
        XCTAssertEqual(numbers.sorted(), numbersFromDeck.sorted())
    }
}

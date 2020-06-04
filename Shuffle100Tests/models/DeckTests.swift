//
//  DeckTests.swift
//  Poems
//
//  Created by 里 佳史 on 2017/04/22.
//  Copyright © 2017年 里 佳史. All rights reserved.
//

import XCTest
@testable import Shuffle100

class DeckTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_initDeck() {
        let deck = Deck()
        XCTAssertNotNil(deck)
    }
    
    func test_hasSize() {
        let deck = Deck()
        XCTAssertEqual(deck.size, 100)
    }
    
    func test_counterAndNextPoem() {
        let deck = Deck()
        // counterの初期値は0
        XCTAssertEqual(deck.counter, 0)
        
        // next_poem関数で、次のオブジェクトを取得できる
        var nextPoem = deck.nextPoem()!
        XCTAssertEqual(nextPoem.number, 1)
        nextPoem = deck.nextPoem()!
        XCTAssertEqual(nextPoem.number, 2)
        
        // counterの値も一つずつ増えているはず。
        XCTAssertEqual(deck.counter, 2)
        
        // next_poemによってPoemを取得し尽くした場合、next_poemはnilを返す
        while deck.counter < 100 {
            _ = deck.nextPoem()
        }
        XCTAssertEqual(deck.counter, 100)
        if let _ = deck.nextPoem() {
            print("ここはnilでなければならないところ！")
            XCTAssertFalse(true)
        } else {
            XCTAssertTrue(true)
        }
    }
    
    func test_rollbackPrevPoem() {
        let deck = Deck()
        // 2枚めくる
        _ = deck.nextPoem()
        _ = deck.nextPoem()
        XCTAssertEqual(deck.counter, 2)
        
        // 1回ロールバックすると、カウンターの値は1になり、歌番号は1番になる。
        let prev_poem = deck.rollBackPoem()!
        XCTAssertEqual(deck.counter, 1)
        XCTAssertEqual(prev_poem.number, 1)
        
        // 2回ロールバックすると、カウンターの値は0になり、返り値としてはnilが返る
        if let _ = deck.rollBackPoem() {
            print("ここはnilでなければならないところ！")
            XCTAssertFalse(true)
        } else {
            XCTAssertTrue(true)
        }
        XCTAssertEqual(deck.counter, 0)
    }
    
    func test_shuffleWithSize() {
        let deck = Deck()
        // シャッフルして何枚の数を取得したいか？のサイズを指定できる。
        deck.shuffleWithSize(size: 10)
        XCTAssertEqual(deck.size, 10)
        // 10回歌データを供給できる
        var p: Poem
        for _ in 1...10 {
            p = deck.nextPoem()!
            XCTAssertNotNil(p)
        }
        // しかし、11回目の歌を供給しようとすると、nilを返す
        if let _ = deck.nextPoem() {
            print("ここはnilでなければならないところ！")
            XCTAssertFalse(true)
        } else {
            XCTAssertTrue(true)
        }
    }
    
    func test_shuffle() {
        // シャッフルする前は、オリジナルの順番通りに並んでいる。
        let org_numbers = Deck.originalPoems.map{$0.number}
        XCTAssertEqual(org_numbers.count, 100)
        let deck = Deck()
        var poems_numbers = deck.poems.map{$0.number}
        XCTAssertEqual(org_numbers, poems_numbers)
        
        // シャッフルすると、オリジナルとは順番が変わる。
        deck.shuffle()
        poems_numbers = deck.poems.map{$0.number}
        XCTAssertEqual(poems_numbers.count, 100)
        XCTAssertNotEqual(org_numbers, poems_numbers)
    }
    
    func test_createFromSelectedState100() {
        var bool100 = SelectedState100.createOf(bool: false)
        bool100.selectOf(number: 1)
        bool100.selectOf(number: 100)
        XCTAssertEqual(bool100.selectedNum, 2)
        
        // 作成したSeletedState100でDockを初期化
        let deck = Deck.createFrom(state100: bool100)
        // SelectedState100でtrueだった位置の歌だけが選択されている
        XCTAssertEqual(deck.size, 2)
        
    }
    
    func test_addFakePoems() {
        var st100 = SelectedState100.createOf(bool: false)

        // まず、3枚選んだ状態に設定
        st100.selectInNumbers([2, 3, 6])
        let deck = Deck.createFrom(state100: st100)
        XCTAssertEqual(deck.size, 3)
        
        // 空札を追加する
        deck.addFakePoems()
        XCTAssertEqual(deck.size, 6)
        
        // 50枚以上のデッキに空札を追加しても、デッキのサイズは2倍にならず、100枚の札が全て選ばれた状態になる
        st100.selectInNumbers((Array<Int>)(1...60))
        let deck2 = Deck.createFrom(state100: st100)
        XCTAssertEqual(deck2.size, 60)
        deck2.addFakePoems()
        XCTAssertEqual(deck2.size, 100)
    }
}

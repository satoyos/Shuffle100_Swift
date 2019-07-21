//
//  PoemsTests.swift
//  PoemsTests
//
//  Created by 里 佳史 on 2017/04/09.
//  Copyright © 2017年 里 佳史. All rights reserved.
//

import XCTest
@testable import Shuffle100

class PoemsTests: XCTestCase {
    
    func testInit_canCreateLiner() {
        let liner = Liner2Parts(kami: "aaa", shimo: "bbb")
        XCTAssertNotNil(liner)
    }
    
    func testInit_canCreatePoem() {
        let poem = Poem(number: 3,
                        poet: "柿本人麻",
                        living_years: "(1000-1100)",
                        liner: ["xxx", "yyy", "zzz", "あああ", "いいい"],
                        in_hiragana: Liner2Parts(
                            kami: "あああああ",
                            shimo: "xxxxx"),
                        in_modern_kana: ["aaa", "bbb", "ccc", "ddd", "eee"],
                        kimari_ji: "かさ")
        XCTAssertNotNil(poem)
    }
    
    func testInit_Poem100shouldHave100Poems() {
        XCTAssertEqual(Poem100.poems.count, 100)
    }
    
    func testInit_Poem100shouldHaveCorrectData() {
        XCTAssertEqual(Poem100.poems[0].number, 1)
        XCTAssertEqual(Poem100.poems[1].in_hiragana.shimo, "ころもほすてふあまのかくやま")
        XCTAssertEqual(Poem100.poems[2].liner.count, 5)
        XCTAssertEqual(Poem100.poems[1].liner[1], "夏来にけらし")
        XCTAssertEqual(Poem100.poems[0].in_modern_kana.count, 5)
        XCTAssertEqual(Poem100.poems[1].in_modern_kana[4], "あまのかぐやま")
        XCTAssertEqual(Poem100.poems[1].living_years, "(645〜702)")
        XCTAssertEqual(Poem100.poems[0].kimari_ji, "あきの")
    }

    func test_strWithNumberAndLiner() {
        let second = Poem100.poems[1]
        XCTAssertEqual(second.strWithNumberAndLiner(), "2. 春過ぎて 夏来にけらし 白妙の 衣干すてふ 天の香具山")
    }
    
    func test_searchText() {
        // given
        let second = Poem100.poems[1]
        // then
        XCTAssertEqual(second.searchText, "2 春過ぎて 夏来にけらし 白妙の 衣干すてふ 天の香具山 はるすきてなつきにけらししろたへの ころもほすてふあまのかくやま はるすぎて なつきにけらし しろたえの ころもほすちょう あまのかぐやま 持統天皇 はるす")
    }
}

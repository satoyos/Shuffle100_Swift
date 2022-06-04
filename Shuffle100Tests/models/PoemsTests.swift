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
    let originalPoems = Poem100.originalPoems
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
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
        XCTAssertEqual(originalPoems.count, 100)
    }
    
    func testInit_Poem100shouldHaveCorrectData() {
        XCTAssertEqual(originalPoems[0].number, 1)
        XCTAssertEqual(originalPoems[1].in_hiragana.shimo, "ころもほすてふあまのかくやま")
        XCTAssertEqual(originalPoems[2].liner.count, 5)
        XCTAssertEqual(originalPoems[1].liner[1], "夏来にけらし")
        XCTAssertEqual(originalPoems[0].in_modern_kana.count, 5)
        XCTAssertEqual(originalPoems[1].in_modern_kana[4], "あまのかぐやま")
        XCTAssertEqual(originalPoems[1].living_years, "(645〜702)")
        XCTAssertEqual(originalPoems[0].kimari_ji, "あきの")
    }

    func test_strWithNumberAndLiner() {
        let second = originalPoems[1]
        XCTAssertEqual(second.strWithNumberAndLiner(), "2. 春過ぎて 夏来にけらし 白妙の 衣干すてふ 天の香具山")
    }
    
    func test_searchText() {
        // given
        let second = originalPoems[1]
        // then
        XCTAssertEqual(second.searchText, "2 春過ぎて 夏来にけらし 白妙の 衣干すてふ 天の香具山 はるすきてなつきにけらししろたへの ころもほすてふあまのかくやま はるすぎて なつきにけらし しろたえの ころもほすちょう あまのかぐやま 持統天皇 はるす")
    }
}

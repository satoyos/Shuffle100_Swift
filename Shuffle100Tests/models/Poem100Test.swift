//
//  Poem100Test.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2022/06/07.
//  Copyright © 2022 里 佳史. All rights reserved.
//

@testable import Shuffle100
import XCTest

class Poem100Test: XCTestCase {

    func test_createFromSelectedState100() {
        // given
        let state100 =
        SelectedState100.createOf(bool: false)
        // when
        let newState100 = state100
                            .selectOf(number: 1)
                            .selectOf(number: 100)
        // then
        XCTAssertEqual(newState100.selectedNum, 2)
        // when: 作成したSeletedState100でDockを初期化
        let deck = newState100.convertToDeck()
        // then: SelectedState100でtrueだった位置の歌だけが選択されている
        XCTAssertEqual(deck.count, 2)
    }
}

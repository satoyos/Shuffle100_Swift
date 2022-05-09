//
//  RecitePoemViewTests.swift
//  RecitePoemViewTests
//
//  Created by 里 佳史 on 2019/07/05.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

class RecitePoemViewTests: XCTestCase {
    let rpView = RecitePoemView()
    
    override func setUpWithError() throws {
        // when
        rpView.initView(title: "test")
    }
    
    func test_initRcitePoemView() {
        // then
        XCTAssertNotNil(rpView)
        XCTAssertNil(rpView.jokaDescLabel)
        XCTAssertNotNil(rpView.forwardButton)
        let config = rpView.forwardButton.configuration
        XCTAssertNotNil(config)
        XCTAssertEqual(config?.title, String.fontAwesomeIcon(name: .forward))
    }
    
    func test_addNormalJokaDescLabel() {
        // when
        rpView.addNormalJokaDescLabel()
        // then
        XCTAssertNotNil(rpView.jokaDescLabel)
        XCTAssertEqual(rpView.jokaDescLabel?.text, "試合開始の合図として読まれる歌です。")
    }
    
    func test_addShortJokaDescLabel() {
        // when
        rpView.addShortJokaDescLabel()
        // then
        XCTAssertNotNil(rpView.jokaDescLabel)
        XCTAssertEqual(rpView.jokaDescLabel?.text, "序歌を途中から読み上げています。")
    }
}

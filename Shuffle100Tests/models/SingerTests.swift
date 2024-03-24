//
//  SingerTests.swift
//  Shuffle100Tests
//
//  Created by 里 佳史 on 2019/07/24.
//  Copyright © 2019 里 佳史. All rights reserved.
//

@testable import Shuffle100
import XCTest

class SingerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_SingersStructHas2SingerStructs() {
        XCTAssertEqual(Singers.all.count, 2)
        let first = Singers.all.first
        XCTAssertEqual(first?.id, "ia")
        let second = Singers.all[1]
        XCTAssertEqual(second.path, "audio/inaba")
    }
    
    func test_defaultSinger() {
        // when
        let singer = Singers.defaultSinger
        // then
        XCTAssertEqual(singer.id, "ia")
    }
    
    func test_getSingerOfID() {
        // when
        if let singer = Singers.getSingerOfID("inaba") {
            XCTAssertEqual(singer.name, "いなばくん（人間）")
        } else {
            XCTFail()
        }
    }
    
    func test_singerHasTimeForShortenJoka() {
        let inaba = Singers.all[1]
        XCTAssertNotNil(inaba.shortenJokaStartTime)
        XCTAssertEqual(inaba.shortenJokaStartTime, 15.5)
    }
}

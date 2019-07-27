//
//  AudioPlayerFactoryTests.swift
//  Shuffle100Tests
//
//  Created by 里 佳史 on 2019/07/27.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

class AudioPlayerFactoryTests: XCTestCase {
    let factory = AudioPlayerFactory.shared

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_createFactoryInstance() {
        XCTAssertNotNil(factory)
    }
    
    func test_prepareOpeningPlayer() {
        // given
        let folderName = "audio/inaba"
        // when
        let player = factory.prepareOpeningPlayer(folder: folderName)
        // then
        XCTAssertNotNil(player)
        
    }

}

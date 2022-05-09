//
//  ReciteViewPlayButtonTest.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2022/05/09.
//  Copyright © 2022 里 佳史. All rights reserved.
//

import XCTest

class ReciteViewPlayButtonTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_playButtonHasConfigurationProperty() {
        // when
        let playButton = ReciteViewPlayButton()
        playButton.configurePlayButton(height: 100, fontSize: 50, iconType: .play, leftInset: true)
        // then
        XCTAssertNotNil(playButton.configuration, "Button Config without UIButton.Configuration gets deprecated from iOS 15.0")
    
    }

}

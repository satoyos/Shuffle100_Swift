//
//  VolumeSettingScreenTest.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2020/04/18.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest
@testable import Shuffle100

class VolumeSettingScreenTest: XCTestCase {

    func test_initialScreen() {
        // given, when
        let screen = VolumeSettingViewController()
        // then
        XCTAssertNotNil(screen)
        // when
        screen.loadViewIfNeeded()
        // then
        XCTAssertEqual(screen.title, "音量の調整")
        // when
        screen.view.layoutSubviews()
        // then
        XCTContext.runActivity(named: "Subviewsが正しく設置されている") { activity in
            XCTAssertNotNil(screen.slider)
            XCTAssertEqual(screen.tryButton.title(for: .normal), "テスト音声を再生する")
        }
        XCTAssertNotNil(screen.currentPlayer)
    }

}

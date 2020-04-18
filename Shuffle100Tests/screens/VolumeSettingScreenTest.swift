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
    }

}

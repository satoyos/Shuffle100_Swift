//
//  StoreManagerTest.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2020/02/14.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class StoreManagerTest: XCTestCase {

    func test_StoreManager() {
        // given
        let store = StoreManager()
        let settings = Settings()
        let keyStr = "Settings"
        // when
        settings.interval = 2.3
        do {
            try store.save(value: settings, key: keyStr)
        } catch {
            XCTFail()
        }
        // then
        if let loadedSettings = store.load(key: keyStr) as Settings? {
            XCTAssertEqual(loadedSettings.interval, 2.3)
        } else {
            XCTFail()
        }
    }
}

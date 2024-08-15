//
//  StoreManagerTest.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2020/02/14.
//  Copyright © 2020 里 佳史. All rights reserved.
//

@testable import Shuffle100
import XCTest

class StoreManagerTest: XCTestCase{
    var env = SHEnvironment()
    
    override func setUp() {
        
    }

    override func tearDown() {
        env.setEnvWontSaveData()
        env.setEnvIgnoreSavedData()
    }

    func test_StoreManager() {
        // given
        let store = StoreManager(env: env)
        let settings = Settings()
        let keyStr = "Test"
        // when
        settings.interval = 2.3
        env.setEnvWillSaveData()
        env.setEnvLoadSavedData()
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

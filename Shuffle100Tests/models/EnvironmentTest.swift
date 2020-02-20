//
//  EnvironmentTest.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2020/02/20.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest
@testable import Shuffle100

class EnvironmentTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_defaultEnvironment() {
        let env = Environment()
        XCTAssertNotNil(env)
        XCTAssertTrue(env.wontSaveData())
        XCTAssertTrue(env.ignoreSavedData())
    }
    
    func test_setEnvWillSaveData() {
        // given
        let env = Environment()
        // when
        env.setEnvWillSaveData()
        // then
        XCTAssertFalse(env.wontSaveData())
    }
    
    func test_setEnvWontSaveData() {
        // given
        let env = Environment()
        env.setEnvWillSaveData()
        XCTAssertFalse(env.wontSaveData())
        // when
        env.setEnvWontSaveData()
        // then
        XCTAssertTrue(env.wontSaveData())
    }

    func test_setEnvLoadDavedData() {
        // given
        let env = Environment()
        // when
        env.setEnvLoadSavedData()
        // then
        XCTAssertFalse(env.ignoreSavedData())
    }
    
    func test_setEnvIgnoreSavedData() {
        // given
        let env = Environment()
        env.setEnvLoadSavedData()
        XCTAssertFalse(env.ignoreSavedData())
        // when
        env.setEnvIgnoreSavedData()
        // then
        XCTAssertTrue(env.ignoreSavedData())
    }
    
}

//
//  CreateFudaSetTest.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2020/05/23.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest

class CreateFudaSetTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_createNewFudaSet() throws {
        // given, // when
        let screen = PoemPickerViewController()
        XCTContext.runActivity(named: "デフォルトのSettingsでは、保存された札セットはない") { activity in
            // then
            XCTAssertEqual(screen.settings.savedFudaSets.count, 0)
        }
        XCTContext.runActivity(named: "札セットを追加すると、その数が変わる") { activity in
            // when
            screen.addNewFudaSet(name: "テストの札セット")
            // then
            XCTAssertEqual(screen.settings.savedFudaSets.count, 1)            
        }
    }

    
}

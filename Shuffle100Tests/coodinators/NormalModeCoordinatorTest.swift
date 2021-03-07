//
//  NormalModeCoordinatorTest.swift
//  Shuffle100Tests
//
//  Created by 里 佳史 on 2019/11/20.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

class NormalModeCoordinatorTest: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_canRetrievePoem() {
        let nc = UINavigationController()
        let coordinator = NormalModeCoordinator(navigationController: nc, settings: Settings(), store: StoreManager())
        var supplier = coordinator.poemSupplier
        XCTAssertNotNil(supplier.drawNextPoem())
    }
}

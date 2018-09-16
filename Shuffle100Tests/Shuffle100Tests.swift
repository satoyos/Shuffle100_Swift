//
//  Shuffle100Tests.swift
//  Shuffle100Tests
//
//  Created by 里 佳史 on 2018/09/08.
//  Copyright © 2018年 里 佳史. All rights reserved.
//

import XCTest
@testable import Shuffle100

class Shuffle100Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_InitScreen() {
        let screen = HomeViewController()
        XCTAssertNotNil(screen)
        screen.viewDidLoad()
        XCTAssertEqual(screen.navigationItem.title, "トップ")
        XCTAssertEqual(screen.view.backgroundColor, UIColor.white)
    }
    
}

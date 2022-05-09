//
//  UIColorExtensionTest.swift
//  Shuffle100Tests
//
//  Created by 里 佳史 on 2019/10/27.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import XCTest

class UIColorExtensionTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_createDynamicColor() {
        // ライトモードでは白、ダークモードでは黒になるUIColorを生成できる
        let dynamicColor = UIColor.dynamicColor(light: .white, dark: .black)
        XCTAssertNotNil(dynamicColor)
        // ダークモードでは黒になる
        
        let tc1 = UITraitCollection(userInterfaceStyle: .dark)
        
        XCTAssertEqual(dynamicColor.resolvedColor(with: tc1), UIColor.black)
        // ライトモードでは白にる
        let tc2 = UITraitCollection(userInterfaceStyle: .light)
        XCTAssertEqual(dynamicColor.resolvedColor(with: tc2), UIColor.white)
    }
}

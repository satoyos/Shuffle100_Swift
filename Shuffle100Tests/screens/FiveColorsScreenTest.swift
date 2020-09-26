//
//  FiveColorsScreenTest.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2020/09/10.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest
import BBBadgeBarButtonItem
@testable import Shuffle100

class FiveColorsScreenTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_initialScreen() throws {
        // given, when
        let screen = FiveColorsViewController()
        // then
        XCTAssertNotNil(screen)
        // when
        screen.loadViewIfNeeded()
        // then
        XCTAssertEqual(screen.title, "五色百人一首")
        XCTAssertEqual(screen.view.subviews.count, 5)
        XCTAssertNotNil(screen.colorsDic)
        XCTContext.runActivity(named: "「青」ボタンが正しく初期設定されている") { _ in
            let button = screen.blueButton
            XCTAssertNotEqual(button.frame.height, 0)
            XCTAssertEqual(button.titleLabel?.text, "青")
        }
        XCTContext.runActivity(named: "バッジアイコンが正しく表示されている") { _ in
            let buttonItem = screen.navigationItem.rightBarButtonItem as? BBBadgeBarButtonItem
            XCTAssertNotNil(buttonItem)
            XCTAssertEqual(buttonItem?.badgeValue, "100首")
        }
    }

}

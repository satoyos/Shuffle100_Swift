//
//  FiveColorsScreenTest.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2020/09/10.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import XCTest
@testable import Shuffle100

class FiveColorsScreenTest: XCTestCase, SelectedNumBadgeTest {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_initialScreen() throws {
        // given, when
        let screen = FiveColorsScreen()
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
            XCTAssertEqual(button.imageView?.tintColor, .systemBlue)
        }
        XCTContext.runActivity(named: "緑ボタンの色も正しく設定されている") { _ in
            XCTAssertEqual(screen.greenButton.imageView?.tintColor, .systemGreen)
        }
        XCTContext.runActivity(named: "バッジアイコンが正しく表示されている") { _ in
            let buttonItem = screen.navigationItem.rightBarButtonItems?.last as? UIBarButtonItem
            XCTAssertNotNil(buttonItem)
            XCTAssertEqual(badgeView(of: screen)?.text, "100首")
        }
    }
    
    func test_badgeIconReflectsSettings() {
        // given
        let settings = Settings()
        let state100 = SelectedState100()
                        .cancelAll()
                        .selectInNumbers([2,4,7])
        settings.state100 = state100
        // when
        let screen = FiveColorsScreen(settings: settings)
        screen.loadViewIfNeeded()
        // then
        XCTAssertEqual(badgeView(of: screen)?.text, "3首")
    }
    
    func test_just20OfBlueColorSelectedAction() {
        // given
        let screen = FiveColorsScreen()
        screen.loadViewIfNeeded()
        // when
        screen.selectJust20Of(color: .blue)
        // then
        XCTAssertEqual(badgeView(of: screen)?.text, "20首")
    }

    func test_add20OfCororSelectedAction() {
        // given
        let settings = Settings()
        let state100 = SelectedState100()
                        .cancelAll()
                        .selectInNumbers([2,4,7])
        settings.state100 = state100
        let screen = FiveColorsScreen(settings: settings)
        screen.loadViewIfNeeded()
        // when
        screen.add20of(color: .yellow)
        // then
        // 既に選ばれている歌と黄色グループは2枚かぶるので、選ばれている歌の数は21になる
        XCTAssertEqual(badgeView(of: screen)?.text, "21首")
    }
    
    func test_imageFilePathReflectsSelectedPoems() {
        XCTContext.runActivity(named: "3, 6, 12の3枚が選ばれている場合、青だけがpartial, そのほかの色はempty") { _ in
            // given
            let screen = FiveColorsScreen()
            // when
            let state100 = SelectedState100()
                            .cancelAll()
                            .selectInNumbers([3 ,6 ,12])
            screen.settings.state100 = state100
            // then
            let bluePath = screen.imageFilePathFor(color: .blue)
            XCTAssert(bluePath.contains("half"))
            let greenPath = screen.imageFilePathFor(color: .green)
            XCTAssert(greenPath.contains("empty"))
        }

    }
}

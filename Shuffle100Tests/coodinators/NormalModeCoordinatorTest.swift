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
    
    func test_jokaRecitingStartsFromMiddlePointOfThePoem() {
        // given
        let nc = UINavigationController()
        let settings = Settings()
        // when
        settings.shortenJoka = true
        let coordinator = NormalModeCoordinator(navigationController: nc, settings: settings, store: StoreManager())
        coordinator.start()
        guard let screen = coordinator.screen as? RecitePoemScreen else {
            XCTFail("NormalModeCoordinatorのscreenプロパティの中の人が、RecitePoemScreenではない！")
            return
        }
        screen.loadViewIfNeeded()
        screen.viewWillLayoutSubviews()
        screen.playJoka(shorten: settings.shortenJoka)
        screen.updateAudioProgressView()
        // then
        guard let player = screen.currentPlayer else {
            XCTFail("RecotePoemScreenからcurrentPlayerを取得できない！！")
            return
        }
        XCTAssert(player.currentTime > 10.0, "序歌の途中から始まっている")
        XCTAssertGreaterThan(screen.recitePoemView.progressView.progress, 0.5, "ProgressViewも半分以上は超えている")
    }
}

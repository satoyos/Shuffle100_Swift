//
//  NormalModeCoordinatorTest.swift
//  Shuffle100Tests
//
//  Created by 里 佳史 on 2019/11/20.
//  Copyright © 2019 里 佳史. All rights reserved.
//

@testable import Shuffle100
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
        let supplier = coordinator.poemSupplier
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

        // SwiftUI版では ActionAttachedHostingController が使われる
        guard let hostController = coordinator.screen else {
            XCTFail("NormalModeCoordinatorのscreenプロパティが見つからない！")
            return
        }

        // ViewModelを取得
        guard let viewModel = coordinator.getCurrentRecitePoemViewModel() else {
            XCTFail("RecitePoemViewModelが取得できない！")
            return
        }

        // ビューの初期化
        hostController.loadViewIfNeeded()
        viewModel.initView(title: "序歌")
        viewModel.playJoka(shorten: settings.shortenJoka)

        // 少し待ってから確認（音声ファイルの読み込み完了を待つ）
        let expectation = XCTestExpectation(description: "Audio loading")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)

        // then
        XCTAssertTrue(viewModel.output.showShortJokaDesc, "短縮序歌の説明が表示されている")
        XCTAssertFalse(viewModel.output.showNormalJokaDesc, "通常序歌の説明は表示されていない")

        guard let player = viewModel.testCurrentPlayer else {
            XCTFail("RecitePoemViewModelからcurrentPlayerを取得できない！！")
            return
        }
        XCTAssert(player.currentTime > 10.0, "序歌の途中から始まっている")
        XCTAssertGreaterThan(viewModel.binding.progressValue, 0.5, "ProgressViewも半分以上は超えている")
    }
}

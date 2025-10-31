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
        guard let baseViewModel = coordinator.getCurrentRecitePoemBaseViewModel() else {
            XCTFail("RecitePoemBaseViewModelが取得できない！")
            return
        }
        let viewModel = baseViewModel.recitePoemViewModel

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

  func test_rewindToPrevious_fromSecondPoemKami_updatesSideToShimo() {
    // このテストは、backToPreviousPoem()がrollBackPrevPoem()を呼んだ後に
    // poemSupplier.stepIntoShimo()を呼んでいないため、sideが.kamiのままになる問題を再現する

    // given: Coordinatorを初期化し、2首目の上の句まで進む
    let nc = UINavigationController()
    let coordinator = NormalModeCoordinator(navigationController: nc, settings: Settings(), store: StoreManager())
    let supplier = coordinator.poemSupplier

    supplier.drawNextPoem()  // 1首目を引く (numberOfPoemsDrawn = 1, side = .kami)
    supplier.stepIntoShimo() // 1首目の下の句へ (side = .shimo)
    supplier.drawNextPoem()  // 2首目を引く (numberOfPoemsDrawn = 2, side = .kami)

    XCTAssertEqual(supplier.currentIndex, 2, "2首目まで進んでいる")
    XCTAssertEqual(supplier.side, .kami, "2首目の上の句なので.kami")

    // when: rewindToPreviousを呼ぶ（内部でbackToPreviousPoem()が呼ばれる）
    // sideが.kamiなので、backToPreviousPoem() → rollBackPrevPoem()が呼ばれる
    coordinator.rewindToPrevious()

    // then:
    // - currentIndexが1に戻る（rollBackPrevPoem()の効果）
    // - sideが.shimoに更新されるべき（backToPreviousPoem()がstepIntoShimo()を呼ぶべき）
    XCTAssertEqual(supplier.currentIndex, 1, "1首目に戻っている")
    XCTAssertEqual(supplier.side, .shimo, "backToPreviousPoem()実行後、sideは.shimoになるべき")
  }

  func test_consecutiveRewinds_fromSecondPoemKami_shouldNotGoBackHome() {
    // このテストは、UIテストで発生している実際の問題シナリオを再現する:
    // 2首目の上の句 → rewind → 1首目の下の句 → rewind → (本来は1首目の上の句だが)HomeScreenに戻ってしまう

    // given: Coordinatorを初期化し、2首目の上の句まで進む
    let nc = UINavigationController()
    let coordinator = NormalModeCoordinator(navigationController: nc, settings: Settings(), store: StoreManager())
    let supplier = coordinator.poemSupplier

    supplier.drawNextPoem()  // 1首目を引く
    supplier.stepIntoShimo() // 1首目の下の句へ
    supplier.drawNextPoem()  // 2首目を引く

    XCTAssertEqual(supplier.currentIndex, 2)
    XCTAssertEqual(supplier.side, .kami)

    // when: 1回目のrewind (2首目の上の句 → 1首目の下の句のはず)
    coordinator.rewindToPrevious()

    XCTAssertEqual(supplier.currentIndex, 1, "1回目のrewind後、1首目に戻る")
    // 問題: この時点でsideは.kamiのまま（本来は.shimoであるべき）
    let sideAfterFirstRewind = supplier.side

    // when: 2回目のrewind (1首目の下の句 → 1首目の上の句のはず)
    // 注意: sideが正しく.shimoになっていれば、slideBackToKami()が呼ばれる
    //       sideが.kamiのままだと、backToPreviousPoem()が再度呼ばれる
    coordinator.rewindToPrevious()

    // then:
    // 期待: slideBackToKami()が呼ばれ、sideが.kamiになり、currentIndexは1のまま
    // 実際（バグ時）: backToPreviousPoem()が呼ばれ、rollBackPrevPoem()がnilを返し、
    //                backToHomeScreen()が呼ばれてしまう
    XCTAssertEqual(supplier.currentIndex, 1, "2回目のrewind後も1首目のまま（indexは変わらない）")

    // sideの検証:
    // - 1回目のrewind後にsideが.shimoになっていれば、2回目のrewindでslideBackToKami()が呼ばれ.kamiになる
    // - 1回目のrewind後にsideが.kamiのままだと、2回目のrewindでbackToPreviousPoem()が呼ばれ、
    //   rollBackPrevPoem()がnilを返し、sideは変わらず.kamiのまま（かつbackToHomeScreen()が呼ばれる）
    XCTAssertEqual(supplier.side, .kami, "2回目のrewind後、sideは.kamiになるべき（slideBackToKami()経由）")

    // 注意: backToHomeScreen()が呼ばれたかどうかを直接検証するのは難しいため、
    // この時点でのsideとcurrentIndexの状態で判断する
    // バグがある場合: sideAfterFirstRewindが.kamiで、rollBackPrevPoem()がnilを返す
    if sideAfterFirstRewind == .kami {
      XCTFail("1回目のrewind後、sideが.shimoになっていない。このため2回目のrewindでbackToHomeScreen()が呼ばれる問題が発生する")
    }
  }
}

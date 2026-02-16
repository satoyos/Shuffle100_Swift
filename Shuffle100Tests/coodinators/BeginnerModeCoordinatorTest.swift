//
//  BeginnerModeCoordinatorTest.swift
//  Shuffle100Tests
//
//  Created by Claude on 2026/02/16.
//
//  初心者モードでrewind（巻き戻し）後に下の句が読み上げられた際、
//  「次はどうする？」画面が表示されるべきことを検証するテスト。
//  バグ: backToPreviousPoem()がplayerFinishedActionを
//  reciteShimoFinished()に設定してしまうため、初心者モードでは本来
//  openWhatsNextScreen()が呼ばれるべきところが、直接次の歌に進んでしまう。

@testable import Shuffle100
import XCTest

class BeginnerModeCoordinatorTest: XCTestCase {

  private func makeCoordinator() -> BeginnerModeCoordinator {
    let nc = UINavigationController()
    let settings = Settings()
    settings.reciteMode = .beginner
    return BeginnerModeCoordinator(
      navigationController: nc, settings: settings, store: StoreManager())
  }

  // MARK: - 通常フロー: 下の句再生後に「次はどうする？」画面が表示される

  /// 通常の流れで下の句に進んだ場合、playerFinishedActionは
  /// reciteShimoFinished（次の歌へ直接進む）を呼ばないことを確認
  func test_normalFlow_shimoFinished_doesNotAdvanceToNextPoem() {
    // given: 1首目の上の句まで進む
    let coordinator = makeCoordinator()
    let supplier = coordinator.poemSupplier
    coordinator.start()

    coordinator.jokaFinished()
    let firstNumber = supplier.currentPoem!.number
    XCTAssertEqual(supplier.currentIndex, 1)

    // when: 上の句の読み上げ完了 → 下の句へ（stepIntoShimoInBeginnerMode）
    coordinator.reciteKamiFinished(number: firstNumber, counter: 1)

    // この時点でplayerFinishedActionにはopenWhatsNextScreenが設定されている
    // playerFinishedActionを手動で呼んで、その結果を検証する
    guard let baseViewModel = coordinator.getCurrentRecitePoemBaseViewModel() else {
      XCTFail("RecitePoemBaseViewModelが取得できない")
      return
    }

    let indexBeforeAction = supplier.currentIndex
    baseViewModel.playerFinishedAction?()

    // then: openWhatsNextScreen()が呼ばれた場合、currentIndexは変わらない
    //       reciteShimoFinished()が呼ばれた場合、drawNextPoem()でcurrentIndexが増える
    XCTAssertEqual(
      supplier.currentIndex, indexBeforeAction,
      "初心者モードの通常フローでは、下の句再生後にcurrentIndexが変わらないべき（openWhatsNextScreenが呼ばれる）"
    )
  }

  // MARK: - rewindフロー: 前の歌の下の句に戻った後もWhatsNext画面が表示されるべき

  /// rewindで前の歌の下の句に戻った後、その下の句の再生完了時に
  /// 「次はどうする？」画面が表示される（次の歌に直接進まない）ことを確認
  func test_rewindToPreviousShimo_playerFinishedAction_doesNotAdvanceToNextPoem() {
    // given: 2首目の上の句まで進む
    let coordinator = makeCoordinator()
    let supplier = coordinator.poemSupplier
    coordinator.start()

    // 序歌 → 1首目の上の句
    coordinator.jokaFinished()
    let firstNumber = supplier.currentPoem!.number

    // 1首目の上の句 → 下の句（stepIntoShimoInBeginnerMode）
    coordinator.reciteKamiFinished(number: firstNumber, counter: 1)

    // 下の句再生完了 → 「次はどうする？」→ 「次の歌へ」→ reciteShimoFinished → 2首目の上の句
    coordinator.reciteShimoFinished(number: firstNumber, counter: 1)

    XCTAssertEqual(supplier.currentIndex, 2, "2首目まで進んでいる")
    XCTAssertEqual(supplier.side, .kami, "2首目の上の句にいる")

    // when: rewindボタン → 1首目の下の句に戻る
    coordinator.rewindToPrevious()

    XCTAssertEqual(supplier.currentIndex, 1, "1首目に戻っている")
    XCTAssertEqual(supplier.side, .shimo, "下の句に戻っている")

    // rewind後、音声が再生され、再生完了時にplayerFinishedActionが呼ばれる
    guard let baseViewModel = coordinator.getCurrentRecitePoemBaseViewModel() else {
      XCTFail("RecitePoemBaseViewModelが取得できない")
      return
    }

    let indexBeforeAction = supplier.currentIndex

    // playerFinishedActionを手動でトリガー（音声再生完了をシミュレート）
    baseViewModel.playerFinishedAction?()

    // then: 初心者モードでは、openWhatsNextScreen()が呼ばれるべき
    //   → currentIndexは変わらない（1のまま）
    // バグがある場合: reciteShimoFinished()が呼ばれ、drawNextPoem()で
    //   currentIndexが2に増えてしまう
    XCTAssertEqual(
      supplier.currentIndex, indexBeforeAction,
      "rewind後の下の句再生完了時、初心者モードではcurrentIndexが変わらないべき（openWhatsNextScreenが呼ばれるべき）。currentIndexが増えた場合、reciteShimoFinished()が誤って呼ばれている。"
    )
  }
}

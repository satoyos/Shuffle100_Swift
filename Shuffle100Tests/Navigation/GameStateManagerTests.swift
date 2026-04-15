//
//  GameStateManagerTests.swift
//  Shuffle100Tests
//
//  GameStateManager の状態遷移ロジックを検証する。
//  音声再生は MockAudioPlayerFactory を注入し、BaseViewModel の closure を
//  直接呼び出して「再生完了」をシミュレートする。
//

@testable import Shuffle100
import XCTest

final class GameStateManagerTests: XCTestCase {

  // MARK: - Helpers

  private func makeSettings(mode: ReciteMode = .normal, poemCount: Int = 3) -> Settings {
    let settings = Settings()
    settings.reciteMode = mode
    return settings
  }

  /// 決定論的に poem を並べた PoemSupplier を作る (shuffle=false)
  private func makeSupplier(poemCount: Int) -> PoemSupplier {
    let originals = PoemSupplier.originalPoems
    let deck = Array(originals.prefix(poemCount))
    return PoemSupplier(deck: deck, shuffle: false)
  }

  private func makeManager(
    mode: ReciteMode,
    strategy: GameStrategy,
    poemCount: Int = 3
  ) -> GameStateManager {
    let settings = makeSettings(mode: mode, poemCount: poemCount)
    let supplier = makeSupplier(poemCount: poemCount)
    return GameStateManager(
      settings: settings,
      store: StoreManager(),
      strategy: strategy,
      poemSupplier: supplier,
      audioPlayerFactory: MockAudioPlayerFactory()
    )
  }

  // MARK: - Normal Mode

  func test_normal_initialPhaseIsJoka() {
    let manager = makeManager(mode: .normal, strategy: NormalGameStrategy())
    XCTAssertEqual(manager.phase, .joka)
  }

  func test_normal_afterJokaFinished_phaseIsKami1() {
    let manager = makeManager(mode: .normal, strategy: NormalGameStrategy())
    manager.startGame()

    // 序歌の再生完了をシミュレート
    manager.baseViewModel.playerFinishedAction?()

    guard case .kami(let number, let counter) = manager.phase else {
      XCTFail("Expected .kami phase, got \(manager.phase)")
      return
    }
    XCTAssertEqual(counter, 1)
    XCTAssertEqual(manager.poemSupplier.currentIndex, 1)
    XCTAssertEqual(manager.poemSupplier.currentPoem?.number, number)
  }

  func test_normal_afterKamiFinished_phaseIsWaitingForShimo() {
    let manager = makeManager(mode: .normal, strategy: NormalGameStrategy())
    manager.startGame()
    manager.baseViewModel.playerFinishedAction?()     // .joka → .kami

    // 上の句終了
    manager.baseViewModel.playerFinishedAction?()

    guard case .waitingForShimo(_, let counter) = manager.phase else {
      XCTFail("Expected .waitingForShimo, got \(manager.phase)")
      return
    }
    XCTAssertEqual(counter, 1)
    XCTAssertEqual(manager.poemSupplier.side, .shimo,
                   "通常モードでは kami 終了後に supplier を shimo 側に進める")
  }

  func test_normal_playButtonTapped_transitionsToShimo() {
    let manager = makeManager(mode: .normal, strategy: NormalGameStrategy())
    manager.startGame()
    manager.baseViewModel.playerFinishedAction?()     // → .kami
    manager.baseViewModel.playerFinishedAction?()     // → .waitingForShimo

    // 再生ボタンタップ
    manager.baseViewModel.playButtonTappedAfterFinishedReciting?()

    guard case .shimo(_, let counter) = manager.phase else {
      XCTFail("Expected .shimo, got \(manager.phase)")
      return
    }
    XCTAssertEqual(counter, 1)
    XCTAssertEqual(manager.poemSupplier.side, .shimo)
  }

  func test_normal_skipDuringKami_transitionsDirectlyToShimo() {
    let manager = makeManager(mode: .normal, strategy: NormalGameStrategy())
    manager.startGame()
    manager.baseViewModel.playerFinishedAction?()     // → .kami(1)

    // kami 中の skip = 直接 shimo へ (waitingForShimo を経由しない)
    manager.baseViewModel.skipToNextScreenAction?()

    guard case .shimo(_, let counter) = manager.phase else {
      XCTFail("Expected .shimo, got \(manager.phase)")
      return
    }
    XCTAssertEqual(counter, 1)
  }

  func test_normal_afterShimoFinished_advancesToNextKami() {
    let manager = makeManager(mode: .normal, strategy: NormalGameStrategy())
    manager.startGame()
    manager.baseViewModel.playerFinishedAction?()     // → .kami(1)
    manager.baseViewModel.playerFinishedAction?()     // → .waitingForShimo(1)
    manager.baseViewModel.playButtonTappedAfterFinishedReciting?()  // → .shimo(1)

    manager.baseViewModel.playerFinishedAction?()     // shimo 終了 → 次の kami

    guard case .kami(_, let counter) = manager.phase else {
      XCTFail("Expected .kami, got \(manager.phase)")
      return
    }
    XCTAssertEqual(counter, 2)
    XCTAssertEqual(manager.poemSupplier.currentIndex, 2)
  }

  func test_normal_lastShimoFinished_transitionsToGameEnd() {
    let manager = makeManager(mode: .normal, strategy: NormalGameStrategy(), poemCount: 1)
    manager.startGame()
    manager.baseViewModel.playerFinishedAction?()     // → .kami(1)
    manager.baseViewModel.playerFinishedAction?()     // → .waitingForShimo(1)
    manager.baseViewModel.playButtonTappedAfterFinishedReciting?()  // → .shimo(1)

    manager.baseViewModel.playerFinishedAction?()     // 最後の shimo 終了

    XCTAssertEqual(manager.phase, .gameEnd)
  }

  // MARK: - Beginner Mode

  func test_beginner_afterKami_autoAdvancesToShimo() {
    let manager = makeManager(mode: .beginner, strategy: BeginnerGameStrategy())
    manager.startGame()
    manager.baseViewModel.playerFinishedAction?()     // → .kami(1)

    manager.baseViewModel.playerFinishedAction?()     // kami 終了 → shimo (自動)

    guard case .shimo(_, let counter) = manager.phase else {
      XCTFail("Expected .shimo, got \(manager.phase)")
      return
    }
    XCTAssertEqual(counter, 1)
  }

  func test_beginner_afterShimo_presentsWhatsNext() {
    let manager = makeManager(mode: .beginner, strategy: BeginnerGameStrategy())
    var presentedPoem: Poem?
    manager.onPresentWhatsNext = { presentedPoem = $0 }

    manager.startGame()
    manager.baseViewModel.playerFinishedAction?()     // → .kami(1)
    manager.baseViewModel.playerFinishedAction?()     // → .shimo(1)
    manager.baseViewModel.playerFinishedAction?()     // → .whatsNext(1)

    guard case .whatsNext(_, let counter) = manager.phase else {
      XCTFail("Expected .whatsNext, got \(manager.phase)")
      return
    }
    XCTAssertEqual(counter, 1)
    XCTAssertNotNil(presentedPoem)
  }

  func test_beginner_lastShimoFinished_stillPresentsWhatsNext() {
    // 最後の歌でも WhatsNext が表示される (ゲーム終了判定は goNext で行う)
    let manager = makeManager(mode: .beginner, strategy: BeginnerGameStrategy(), poemCount: 1)
    var presentedCount = 0
    manager.onPresentWhatsNext = { _ in presentedCount += 1 }

    manager.startGame()
    manager.baseViewModel.playerFinishedAction?()     // → .kami(1)
    manager.baseViewModel.playerFinishedAction?()     // → .shimo(1)
    manager.baseViewModel.playerFinishedAction?()     // → .whatsNext(1)

    guard case .whatsNext = manager.phase else {
      XCTFail("Expected .whatsNext even for last poem, got \(manager.phase)")
      return
    }
    XCTAssertEqual(presentedCount, 1)
  }

  func test_beginner_goNext_withNextPoem_transitionsToKami() {
    let manager = makeManager(mode: .beginner, strategy: BeginnerGameStrategy())
    manager.startGame()
    manager.baseViewModel.playerFinishedAction?()
    manager.baseViewModel.playerFinishedAction?()
    manager.baseViewModel.playerFinishedAction?()     // → .whatsNext(1)

    manager.handleGoNext()

    guard case .kami(_, let counter) = manager.phase else {
      XCTFail("Expected .kami, got \(manager.phase)")
      return
    }
    XCTAssertEqual(counter, 2)
  }

  func test_beginner_goNext_withoutNextPoem_transitionsToGameEnd() {
    let manager = makeManager(mode: .beginner, strategy: BeginnerGameStrategy(), poemCount: 1)
    manager.startGame()
    manager.baseViewModel.playerFinishedAction?()
    manager.baseViewModel.playerFinishedAction?()
    manager.baseViewModel.playerFinishedAction?()     // → .whatsNext(1)

    manager.handleGoNext()

    XCTAssertEqual(manager.phase, .gameEnd)
  }

  // MARK: - Nonstop Mode

  func test_nonstop_continuousPlayback_afterShimoGoesToNextKami() {
    let manager = makeManager(mode: .nonstop, strategy: NonstopGameStrategy())
    manager.startGame()
    manager.baseViewModel.playerFinishedAction?()     // → .kami(1)
    manager.baseViewModel.playerFinishedAction?()     // → .shimo(1)  (auto)

    guard case .shimo(_, let c1) = manager.phase else {
      XCTFail("Expected .shimo, got \(manager.phase)")
      return
    }
    XCTAssertEqual(c1, 1)

    manager.baseViewModel.playerFinishedAction?()     // → .kami(2)

    guard case .kami(_, let c2) = manager.phase else {
      XCTFail("Expected .kami, got \(manager.phase)")
      return
    }
    XCTAssertEqual(c2, 2)
  }

  // MARK: - Hokkaido Mode

  func test_hokkaido_afterJoka_goesDirectlyToShimo() {
    let manager = makeManager(mode: .hokkaido, strategy: HokkaidoGameStrategy())
    manager.startGame()

    manager.baseViewModel.playerFinishedAction?()     // 序歌 → shimo(1)

    guard case .shimo(_, let counter) = manager.phase else {
      XCTFail("Expected .shimo, got \(manager.phase)")
      return
    }
    XCTAssertEqual(counter, 1)
    XCTAssertEqual(manager.poemSupplier.side, .shimo)
  }

  func test_hokkaido_afterShimo_presentsWhatsNext() {
    let manager = makeManager(mode: .hokkaido, strategy: HokkaidoGameStrategy())
    var presented = 0
    manager.onPresentWhatsNext = { _ in presented += 1 }

    manager.startGame()
    manager.baseViewModel.playerFinishedAction?()     // → .shimo(1)
    manager.baseViewModel.playerFinishedAction?()     // → .whatsNext(1)

    guard case .whatsNext = manager.phase else {
      XCTFail("Expected .whatsNext, got \(manager.phase)")
      return
    }
    XCTAssertEqual(presented, 1)
  }

  func test_hokkaido_goNext_entersShimoRefrainBeforeAdvance() {
    let manager = makeManager(mode: .hokkaido, strategy: HokkaidoGameStrategy())
    manager.startGame()
    manager.baseViewModel.playerFinishedAction?()     // → .shimo(1)
    manager.baseViewModel.playerFinishedAction?()     // → .whatsNext(1)

    manager.handleGoNext()

    guard case .shimoRefrainBeforeAdvance(_, let counter) = manager.phase else {
      XCTFail("Expected .shimoRefrainBeforeAdvance, got \(manager.phase)")
      return
    }
    XCTAssertEqual(counter, 1)
  }

  func test_hokkaido_afterShimoRefrainFinished_goesToNextShimoDirectly() {
    let manager = makeManager(mode: .hokkaido, strategy: HokkaidoGameStrategy())
    var presented = 0
    manager.onPresentWhatsNext = { _ in presented += 1 }

    manager.startGame()
    manager.baseViewModel.playerFinishedAction?()     // → .shimo(1)
    manager.baseViewModel.playerFinishedAction?()     // → .whatsNext(1)
    XCTAssertEqual(presented, 1)

    manager.handleGoNext()                            // → .shimoRefrainBeforeAdvance(1)
    manager.baseViewModel.playerFinishedAction?()     // refrain 終了 → .shimo(2) (WhatsNext を挟まない)

    guard case .shimo(_, let counter) = manager.phase else {
      XCTFail("Expected .shimo, got \(manager.phase)")
      return
    }
    XCTAssertEqual(counter, 2)
    XCTAssertEqual(presented, 1, "refrain 終了直後に WhatsNext を再表示してはいけない")
  }

  func test_hokkaido_goNextOnLastPoem_transitionsToGameEnd() {
    let manager = makeManager(mode: .hokkaido, strategy: HokkaidoGameStrategy(), poemCount: 1)
    manager.startGame()
    manager.baseViewModel.playerFinishedAction?()     // → .shimo(1)
    manager.baseViewModel.playerFinishedAction?()     // → .whatsNext(1)

    manager.handleGoNext()

    XCTAssertEqual(manager.phase, .gameEnd)
  }

  // MARK: - Rewind

  func test_normal_rewindOnJoka_callsBackToHome() {
    let manager = makeManager(mode: .normal, strategy: NormalGameStrategy())
    var backCalled = false
    manager.onBackToHome = { backCalled = true }

    manager.startGame()
    manager.baseViewModel.recitePoemViewModel.backToPreviousAction?()

    XCTAssertTrue(backCalled)
  }

  func test_normal_rewindOnKami_goesBackToPreviousPoemShimo() {
    let manager = makeManager(mode: .normal, strategy: NormalGameStrategy())
    manager.startGame()
    manager.baseViewModel.playerFinishedAction?()     // → .kami(1)
    manager.baseViewModel.playerFinishedAction?()     // → .waitingForShimo(1)
    manager.baseViewModel.playButtonTappedAfterFinishedReciting?()  // → .shimo(1)
    manager.baseViewModel.playerFinishedAction?()     // → .kami(2)

    // .kami(2) で rewind → 1首目の下の句に戻る
    manager.baseViewModel.recitePoemViewModel.backToPreviousAction?()

    guard case .shimo(_, let counter) = manager.phase else {
      XCTFail("Expected .shimo after rewind from kami, got \(manager.phase)")
      return
    }
    XCTAssertEqual(counter, 1)
    XCTAssertEqual(manager.poemSupplier.currentIndex, 1)
    XCTAssertEqual(manager.poemSupplier.side, .shimo)
  }

  func test_normal_rewindOnFirstKami_callsBackToHome() {
    let manager = makeManager(mode: .normal, strategy: NormalGameStrategy())
    var backCalled = false
    manager.onBackToHome = { backCalled = true }

    manager.startGame()
    manager.baseViewModel.playerFinishedAction?()     // → .kami(1)

    // 1首目の上の句冒頭で rewind → ホームへ
    manager.baseViewModel.recitePoemViewModel.backToPreviousAction?()

    XCTAssertTrue(backCalled)
  }

  func test_hokkaido_rewindDuringShimo_goesBackToPreviousShimo() {
    let manager = makeManager(mode: .hokkaido, strategy: HokkaidoGameStrategy())
    manager.startGame()
    manager.baseViewModel.playerFinishedAction?()     // → .shimo(1)
    manager.baseViewModel.playerFinishedAction?()     // → .whatsNext(1)
    manager.handleGoNext()                            // → .shimoRefrainBeforeAdvance(1)
    manager.baseViewModel.playerFinishedAction?()     // refrain 終了 → .shimo(2)

    // .shimo(2) で rewind → 1首目の下の句に戻る
    manager.baseViewModel.recitePoemViewModel.backToPreviousAction?()

    guard case .shimo(_, let counter) = manager.phase else {
      XCTFail("Expected .shimo after rewind, got \(manager.phase)")
      return
    }
    XCTAssertEqual(counter, 1)
    XCTAssertEqual(manager.poemSupplier.currentIndex, 1)
  }

  // MARK: - PostMortem (感想戦)

  func test_postMortem_resetsSupplierAndRestartsFromJoka() {
    let manager = makeManager(mode: .normal, strategy: NormalGameStrategy(), poemCount: 1)
    manager.startGame()
    manager.baseViewModel.playerFinishedAction?()     // → .kami(1)
    manager.baseViewModel.playerFinishedAction?()     // → .waitingForShimo(1)
    manager.baseViewModel.playButtonTappedAfterFinishedReciting?()  // → .shimo(1)
    manager.baseViewModel.playerFinishedAction?()     // → .gameEnd
    XCTAssertEqual(manager.phase, .gameEnd)

    // 感想戦開始 (startPostMortemAction 経由)
    manager.baseViewModel.recitePoemViewModel.startPostMortemAction?()

    XCTAssertEqual(manager.phase, .joka)
    XCTAssertEqual(manager.poemSupplier.currentIndex, 0)
  }

  func test_normal_rewindDuringShimo_goesBackToKami() {
    let manager = makeManager(mode: .normal, strategy: NormalGameStrategy())
    manager.startGame()
    manager.baseViewModel.playerFinishedAction?()     // → .kami(1)
    manager.baseViewModel.playerFinishedAction?()     // → .waitingForShimo(1)
    manager.baseViewModel.playButtonTappedAfterFinishedReciting?()  // → .shimo(1)

    manager.baseViewModel.recitePoemViewModel.backToPreviousAction?()

    guard case .kami(_, let counter) = manager.phase else {
      XCTFail("Expected .kami after rewind, got \(manager.phase)")
      return
    }
    XCTAssertEqual(counter, 1)
    XCTAssertEqual(manager.poemSupplier.side, .kami)
  }
}

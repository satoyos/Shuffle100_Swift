//
//  GameStrategyTests.swift
//  Shuffle100Tests
//
//  各ゲームモードの Strategy の状態遷移ロジックをテストする。
//

@testable import Shuffle100
import XCTest

final class GameStrategyTests: XCTestCase {

  // MARK: - NormalGameStrategy

  func test_normal_propertiesAreCorrect() {
    let strategy = NormalGameStrategy()
    XCTAssertFalse(strategy.forcesShortenedJoka)
    XCTAssertTrue(strategy.hasKami)
    XCTAssertFalse(strategy.autoAdvanceFromKami, "通常モードはユーザーのタップ待ち")
    XCTAssertFalse(strategy.showsWhatsNext)
  }

  func test_normal_afterJoka_goesToKami() {
    let strategy = NormalGameStrategy()
    XCTAssertEqual(strategy.nextPhaseAfterJoka(firstPoemNumber: 7),
                   .kami(number: 7, counter: 1))
  }

  func test_normal_afterKami_waitsForShimo() {
    let strategy = NormalGameStrategy()
    XCTAssertEqual(strategy.nextPhaseAfterKami(number: 7, counter: 1),
                   .waitingForShimo(number: 7, counter: 1))
  }

  func test_normal_afterShimo_withNextPoem_goesToKami() {
    let strategy = NormalGameStrategy()
    XCTAssertEqual(
      strategy.nextPhaseAfterShimo(number: 7, counter: 1, nextPoemNumber: 12, nextCounter: 2),
      .kami(number: 12, counter: 2)
    )
  }

  func test_normal_afterShimo_withoutNextPoem_goesToGameEnd() {
    let strategy = NormalGameStrategy()
    XCTAssertEqual(
      strategy.nextPhaseAfterShimo(number: 7, counter: 1, nextPoemNumber: nil, nextCounter: 2),
      .gameEnd
    )
  }

  // MARK: - BeginnerGameStrategy

  func test_beginner_propertiesAreCorrect() {
    let strategy = BeginnerGameStrategy()
    XCTAssertFalse(strategy.forcesShortenedJoka)
    XCTAssertTrue(strategy.hasKami)
    XCTAssertTrue(strategy.autoAdvanceFromKami)
    XCTAssertTrue(strategy.showsWhatsNext)
  }

  func test_beginner_afterKami_goesToShimo() {
    let strategy = BeginnerGameStrategy()
    XCTAssertEqual(strategy.nextPhaseAfterKami(number: 7, counter: 1),
                   .shimo(number: 7, counter: 1))
  }

  func test_beginner_afterShimo_withNextPoem_goesToWhatsNext() {
    let strategy = BeginnerGameStrategy()
    XCTAssertEqual(
      strategy.nextPhaseAfterShimo(number: 7, counter: 1, nextPoemNumber: 12, nextCounter: 2),
      .whatsNext(number: 7, counter: 1)
    )
  }

  func test_beginner_afterShimo_withoutNextPoem_stillGoesToWhatsNext() {
    // 最後の歌でも、下の句終了後は必ず WhatsNext 画面を表示する。
    // ゲーム終了判定は WhatsNext で「次の歌へ」を押したときに行う。
    let strategy = BeginnerGameStrategy()
    XCTAssertEqual(
      strategy.nextPhaseAfterShimo(number: 7, counter: 1, nextPoemNumber: nil, nextCounter: 2),
      .whatsNext(number: 7, counter: 1)
    )
  }

  func test_beginner_afterGoNext_withNextPoem_goesToKami() {
    let strategy = BeginnerGameStrategy()
    XCTAssertEqual(
      strategy.nextPhaseAfterGoNext(
        currentNumber: 7, currentCounter: 1,
        nextPoemNumber: 12, nextCounter: 2
      ),
      .kami(number: 12, counter: 2)
    )
  }

  func test_beginner_afterGoNext_withoutNextPoem_goesToGameEnd() {
    // WhatsNext 画面で「次の歌へ」が押されたが、もう次の歌がない場合 → ゲーム終了
    let strategy = BeginnerGameStrategy()
    XCTAssertEqual(
      strategy.nextPhaseAfterGoNext(
        currentNumber: 7, currentCounter: 1,
        nextPoemNumber: nil, nextCounter: 2
      ),
      .gameEnd
    )
  }

  // MARK: - NonstopGameStrategy

  func test_nonstop_propertiesAreCorrect() {
    let strategy = NonstopGameStrategy()
    XCTAssertFalse(strategy.forcesShortenedJoka)
    XCTAssertTrue(strategy.hasKami)
    XCTAssertTrue(strategy.autoAdvanceFromKami)
    XCTAssertFalse(strategy.showsWhatsNext)
  }

  func test_nonstop_afterKami_goesToShimo() {
    let strategy = NonstopGameStrategy()
    XCTAssertEqual(strategy.nextPhaseAfterKami(number: 7, counter: 1),
                   .shimo(number: 7, counter: 1))
  }

  func test_nonstop_afterShimo_withNextPoem_goesToKami() {
    let strategy = NonstopGameStrategy()
    XCTAssertEqual(
      strategy.nextPhaseAfterShimo(number: 7, counter: 1, nextPoemNumber: 12, nextCounter: 2),
      .kami(number: 12, counter: 2)
    )
  }

  // MARK: - HokkaidoGameStrategy

  func test_hokkaido_propertiesAreCorrect() {
    let strategy = HokkaidoGameStrategy()
    XCTAssertTrue(strategy.forcesShortenedJoka, "北海道モードは序歌を強制短縮")
    XCTAssertFalse(strategy.hasKami, "北海道モードは上の句なし")
    XCTAssertTrue(strategy.showsWhatsNext)
  }

  func test_hokkaido_afterJoka_goesDirectlyToShimo() {
    let strategy = HokkaidoGameStrategy()
    XCTAssertEqual(strategy.nextPhaseAfterJoka(firstPoemNumber: 7),
                   .shimo(number: 7, counter: 1))
  }

  func test_hokkaido_afterShimo_withNextPoem_goesToWhatsNext() {
    let strategy = HokkaidoGameStrategy()
    XCTAssertEqual(
      strategy.nextPhaseAfterShimo(number: 7, counter: 1, nextPoemNumber: 12, nextCounter: 2),
      .whatsNext(number: 7, counter: 1)
    )
  }

  func test_hokkaido_afterShimo_withoutNextPoem_stillGoesToWhatsNext() {
    // 最後の歌でも、下の句終了後は必ず WhatsNext 画面を表示する。
    // ゲーム終了判定は WhatsNext で「次の歌へ」を押したときに行う。
    let strategy = HokkaidoGameStrategy()
    XCTAssertEqual(
      strategy.nextPhaseAfterShimo(number: 7, counter: 1, nextPoemNumber: nil, nextCounter: 2),
      .whatsNext(number: 7, counter: 1)
    )
  }

  func test_hokkaido_afterGoNext_withNextPoem_goesToShimoRefrainBeforeAdvance() {
    // 北海道モード: 「次の歌へ」が押されると、まず現在の歌の下の句を refrain 再生する。
    // その後、WhatsNext を表示せず次の歌の下の句へ直接遷移する
    // （GameStateManager 側で shimoRefrainBeforeAdvance 終了後に処理）。
    let strategy = HokkaidoGameStrategy()
    XCTAssertEqual(
      strategy.nextPhaseAfterGoNext(
        currentNumber: 7, currentCounter: 1,
        nextPoemNumber: 12, nextCounter: 2
      ),
      .shimoRefrainBeforeAdvance(number: 7, counter: 1),
      "北海道モードでは「次の歌へ」押下後に現在の下の句を refrain 再生するフェーズへ入る"
    )
  }

  func test_hokkaido_afterGoNext_withoutNextPoem_goesToGameEnd() {
    // WhatsNext 画面で「次の歌へ」が押されたが、もう次の歌がない場合 → ゲーム終了
    let strategy = HokkaidoGameStrategy()
    XCTAssertEqual(
      strategy.nextPhaseAfterGoNext(
        currentNumber: 7, currentCounter: 1,
        nextPoemNumber: nil, nextCounter: 2
      ),
      .gameEnd
    )
  }
}

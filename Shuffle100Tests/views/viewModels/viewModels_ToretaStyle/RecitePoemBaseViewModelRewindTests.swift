//
//  RecitePoemBaseViewModelRewindTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2026/02/16.
//
//  巻き戻し（rewind）時に正しい音声ファイルがロードされることを検証するテスト。
//  現状のバグ: slideBackToKami / goBackToPrevPoem 呼び出し後、
//  currentPlayer が古い音声のまま更新されない。

import XCTest
import Combine
import AVFoundation
@testable import Shuffle100

final class RecitePoemBaseViewModelRewindTests: XCTestCase {

  var baseViewModel: RecitePoemBaseViewModel!
  var testSettings: Settings!
  var mockFactory: MockAudioPlayerFactory!
  var cancellables: Set<AnyCancellable>!

  override func setUpWithError() throws {
    testSettings = Settings()
    testSettings.singerID = "ia"
    testSettings.interval = 0.0       // テストではアニメーション待ちを最小にする
    testSettings.kamiShimoInterval = 0.0
    mockFactory = MockAudioPlayerFactory()
    baseViewModel = RecitePoemBaseViewModel(settings: testSettings, audioPlayerFactory: mockFactory)
    baseViewModel.recitePoemViewModel.enableTestMode()
    cancellables = Set<AnyCancellable>()
  }

  override func tearDownWithError() throws {
    baseViewModel = nil
    testSettings = nil
    mockFactory = nil
    cancellables.removeAll()
    cancellables = nil
  }

  // MARK: - slideBackToKami のテスト（下の句 → 上の句に戻る）

  /// slideBackToKami呼び出し後、上の句の音声がcurrentPlayerにロードされるべき
  func test_slideBackToKami_preparesKamiAudioPlayer() throws {
    // Arrange: まず下の句（shimo）の音声を再生中の状態にする
    baseViewModel.recitePoemViewModel.playNumberedPoem(number: 5, side: .shimo, count: 1)
    XCTAssertTrue(mockFactory.preparePlayerWithNumberCalled)
    XCTAssertEqual(mockFactory.lastPreparedNumber, 5)
    XCTAssertEqual(mockFactory.lastPreparedSide, .shimo)

    // モックのトラッキングをリセット
    mockFactory.reset()

    // Act: 上の句に戻る
    baseViewModel.slideBackToKami(number: 5, at: 1, total: 10)

    // Assert: 上の句（kami）の音声ファイルがロードされるべき
    // 【バグ】現状ではslideBackToKamiが音声をロードしないため、このアサーションは失敗する
    XCTAssertTrue(
      mockFactory.preparePlayerWithNumberCalled,
      "slideBackToKami は歌番号5の上の句の音声をロードすべきだが、現状はロードしていない"
    )
    XCTAssertEqual(
      mockFactory.lastPreparedNumber, 5,
      "歌番号5の音声がロードされるべき"
    )
    XCTAssertEqual(
      mockFactory.lastPreparedSide, .kami,
      "上の句（kami）の音声がロードされるべき"
    )
  }

  /// slideBackToKami後にPlayボタンを押したとき、古い（下の句の）音声ではなく上の句の音声が再生されるべき
  func test_slideBackToKami_afterPlayButtonTap_playsCorrectAudio() throws {
    // Arrange: 下の句を再生し、再生完了状態にする
    baseViewModel.recitePoemViewModel.playNumberedPoem(number: 5, side: .shimo, count: 1)
    let player = baseViewModel.recitePoemViewModel.currentPlayer!
    baseViewModel.recitePoemViewModel.audioPlayerDidFinishPlaying(player, successfully: true)
    XCTAssertTrue(baseViewModel.recitePoemViewModel.playFinished)

    // モックのトラッキングをリセット
    mockFactory.reset()

    // Act: 上の句に戻る
    baseViewModel.slideBackToKami(number: 5, at: 1, total: 10)

    // Assert: currentPlayerが上の句の音声に更新されているべき
    // 【バグ】現状ではcurrentPlayerが古い下の句のままなので、
    //         Playボタンを押しても正しい音声が流れない
    XCTAssertTrue(
      mockFactory.preparePlayerWithNumberCalled,
      "slideBackToKami は新しい音声プレイヤーを準備すべき"
    )
  }

  // MARK: - goBackToPrevPoem のテスト（前の歌の下の句に戻る）

  /// goBackToPrevPoem呼び出し後、前の歌の下の句の音声がcurrentPlayerにロードされるべき
  func test_goBackToPrevPoem_preparesShimoAudioPlayer() throws {
    // Arrange: 歌番号3の上の句を再生中の状態にする
    baseViewModel.recitePoemViewModel.playNumberedPoem(number: 3, side: .kami, count: 2)
    XCTAssertTrue(mockFactory.preparePlayerWithNumberCalled)
    XCTAssertEqual(mockFactory.lastPreparedNumber, 3)
    XCTAssertEqual(mockFactory.lastPreparedSide, .kami)

    // モックのトラッキングをリセット
    mockFactory.reset()

    // Act: 前の歌（歌番号2）の下の句に戻る
    baseViewModel.goBackToPrevPoem(number: 2, at: 1, total: 10)

    // Assert: 前の歌（歌番号2）の下の句の音声がロードされるべき
    // 【バグ】現状ではgoBackToPrevPoemが音声をロードしないため、このアサーションは失敗する
    XCTAssertTrue(
      mockFactory.preparePlayerWithNumberCalled,
      "goBackToPrevPoem は歌番号2の下の句の音声をロードすべきだが、現状はロードしていない"
    )
    XCTAssertEqual(
      mockFactory.lastPreparedNumber, 2,
      "歌番号2の音声がロードされるべき"
    )
    XCTAssertEqual(
      mockFactory.lastPreparedSide, .shimo,
      "下の句（shimo）の音声がロードされるべき"
    )
  }

  /// goBackToPrevPoem後にPlayボタンを押したとき、古い音声ではなく前の歌の下の句が再生されるべき
  func test_goBackToPrevPoem_afterPlayButtonTap_playsCorrectAudio() throws {
    // Arrange: 歌番号3の上の句を再生し、再生完了状態にする
    baseViewModel.recitePoemViewModel.playNumberedPoem(number: 3, side: .kami, count: 2)
    let player = baseViewModel.recitePoemViewModel.currentPlayer!
    baseViewModel.recitePoemViewModel.audioPlayerDidFinishPlaying(player, successfully: true)
    XCTAssertTrue(baseViewModel.recitePoemViewModel.playFinished)

    // モックのトラッキングをリセット
    mockFactory.reset()

    // Act: 前の歌（歌番号2）の下の句に戻る
    baseViewModel.goBackToPrevPoem(number: 2, at: 1, total: 10)

    // Assert: currentPlayerが前の歌の下の句の音声に更新されているべき
    // 【バグ】現状ではcurrentPlayerが古い上の句のままなので、
    //         Playボタンを押しても正しい音声が流れない
    XCTAssertTrue(
      mockFactory.preparePlayerWithNumberCalled,
      "goBackToPrevPoem は新しい音声プレイヤーを準備すべき"
    )
  }
}

//
//  RecitePoemViewModelAudioTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2025/10/08.
//

import XCTest
import Combine
import AVFoundation
@testable import Shuffle100

final class RecitePoemViewModelAudioTests: XCTestCase {

  var viewModel: RecitePoemViewModel!
  var testSettings: Settings!
  var mockFactory: MockAudioPlayerFactory!
  var cancellables: Set<AnyCancellable>!

  override func setUpWithError() throws {
    testSettings = Settings()
    testSettings.singerID = "ia"
    mockFactory = MockAudioPlayerFactory()
    viewModel = RecitePoemViewModel(settings: testSettings, audioPlayerFactory: mockFactory)
    viewModel.enableTestMode()
    cancellables = Set<AnyCancellable>()
  }

  override func tearDownWithError() throws {
    viewModel = nil
    testSettings = nil
    mockFactory = nil
    cancellables.removeAll()
    cancellables = nil
  }

  // MARK: - Joka Playback Tests

  func test_playJoka_normal_callsFactoryAndShowsDescription() throws {
    viewModel.playJoka(shorten: false)

    // Factory should be called with correct folder
    XCTAssertTrue(mockFactory.prepareOpeningPlayerCalled)
    XCTAssertEqual(mockFactory.lastOpeningPlayerFolder, "audio/ia")

    // Should show normal joka description
    XCTAssertTrue(viewModel.output.showNormalJokaDesc)
    XCTAssertFalse(viewModel.output.showShortJokaDesc)

    // Player should be set
    XCTAssertNotNil(viewModel.currentPlayer)
  }

  func test_playJoka_shortened_showsShortDescription() throws {
    viewModel.playJoka(shorten: true)

    // Should show short joka description
    XCTAssertTrue(viewModel.output.showShortJokaDesc)
    XCTAssertFalse(viewModel.output.showNormalJokaDesc)
  }

  // MARK: - Numbered Poem Playback Tests

  func test_playNumberedPoem_kami_callsFactoryWithCorrectParameters() throws {
    viewModel.playNumberedPoem(number: 5, side: .kami)

    // Factory should be called with correct parameters
    XCTAssertTrue(mockFactory.preparePlayerWithNumberCalled)
    XCTAssertEqual(mockFactory.lastPreparedNumber, 5)
    XCTAssertTrue(mockFactory.lastPreparedSide == .kami)
    XCTAssertEqual(mockFactory.lastPlayerFolder, "audio/ia")

    // Player should be set
    XCTAssertNotNil(viewModel.currentPlayer)
  }

  func test_playNumberedPoem_shimo_callsFactoryWithCorrectParameters() throws {
    viewModel.playNumberedPoem(number: 10, side: .shimo)

    // Factory should be called with correct parameters
    XCTAssertTrue(mockFactory.preparePlayerWithNumberCalled)
    XCTAssertEqual(mockFactory.lastPreparedNumber, 10)
    XCTAssertTrue(mockFactory.lastPreparedSide == .shimo)
  }

  func test_playNumberedPoem_hidesJokaDescLabels() throws {
    // First show joka description
    viewModel.addNormalJokaDescLabel()
    XCTAssertTrue(viewModel.output.showNormalJokaDesc)

    // Play numbered poem should hide it
    viewModel.playNumberedPoem(number: 1, side: .kami)

    XCTAssertFalse(viewModel.output.showNormalJokaDesc)
    XCTAssertFalse(viewModel.output.showShortJokaDesc)
  }

  // MARK: - Play/Pause Control Tests

  func test_flipPlaying_whenPlaying_pauses() throws {
    viewModel.playNumberedPoem(number: 1, side: .kami)

    guard let player = viewModel.currentPlayer else {
      XCTFail("Player should be created")
      return
    }

    // Initially the player should be playing
    XCTAssertTrue(player.isPlaying)
    XCTAssertEqual(viewModel.playButtonViewModel.output.type, .pause)

    // Flip should pause
    viewModel.flipPlaying()

    XCTAssertFalse(player.isPlaying)
    XCTAssertEqual(viewModel.playButtonViewModel.output.type, .play)
  }

  func test_flipPlaying_whenPaused_resumes() throws {
    viewModel.playNumberedPoem(number: 1, side: .kami)

    guard let player = viewModel.currentPlayer else {
      XCTFail("Player should be created")
      return
    }

    // Pause first
    viewModel.pauseCurrentPlayer()
    XCTAssertFalse(player.isPlaying)

    // Flip should resume
    viewModel.flipPlaying()

    XCTAssertTrue(player.isPlaying)
    XCTAssertEqual(viewModel.playButtonViewModel.output.type, .pause)
  }

  func test_pauseCurrentPlayer_updatesButtonState() throws {
    viewModel.playNumberedPoem(number: 1, side: .kami)

    guard let player = viewModel.currentPlayer else {
      XCTFail("Player should be created")
      return
    }

    viewModel.pauseCurrentPlayer()

    XCTAssertFalse(player.isPlaying)
    XCTAssertEqual(viewModel.playButtonViewModel.output.type, .play)
  }

  func test_playCurrentPlayer_updatesButtonState() throws {
    viewModel.playNumberedPoem(number: 1, side: .kami)

    guard let player = viewModel.currentPlayer else {
      XCTFail("Player should be created")
      return
    }

    // Pause first
    player.pause()

    // Then play
    viewModel.playCurrentPlayer()

    XCTAssertTrue(player.isPlaying)
    XCTAssertEqual(viewModel.playButtonViewModel.output.type, .pause)
  }

  // MARK: - Progress Management Tests

  func test_updateAudioProgressView_updatesProgressValue() throws {
    viewModel.playNumberedPoem(number: 1, side: .kami)

    guard let player = viewModel.currentPlayer else {
      XCTFail("Player should be created")
      return
    }

    // Initially progress should be 0
    XCTAssertEqual(viewModel.binding.progressValue, 0.0)

    // Simulate some playback time
    player.currentTime = player.duration * 0.5

    // Update progress
    viewModel.updateAudioProgressView()

    // Progress should be approximately 0.5
    XCTAssertEqual(viewModel.binding.progressValue, 0.5, accuracy: 0.01)
  }

  func test_audioPlayerDidFinishPlaying_updatesState() throws {
    viewModel.playNumberedPoem(number: 1, side: .kami)

    guard let player = viewModel.currentPlayer else {
      XCTFail("Player should be created")
      return
    }

    // Initially not finished
    XCTAssertFalse(viewModel.playFinished)

    // Simulate finish
    viewModel.audioPlayerDidFinishPlaying(player, successfully: true)

    // Should update state
    XCTAssertTrue(viewModel.playFinished)
    XCTAssertEqual(viewModel.binding.progressValue, 1.0)
  }

  // MARK: - Multiple Playback Tests

  func test_playNumberedPoem_multipleTimes_replacesPlayer() throws {
    // Play first poem
    viewModel.playNumberedPoem(number: 1, side: .kami)
    XCTAssertEqual(mockFactory.lastPreparedNumber, 1)
    XCTAssertTrue(mockFactory.lastPreparedSide == .kami)

    // Reset mock tracking
    mockFactory.preparePlayerWithNumberCalled = false

    // Play second poem
    viewModel.playNumberedPoem(number: 2, side: .shimo)

    // Factory should be called again
    XCTAssertTrue(mockFactory.preparePlayerWithNumberCalled)
    XCTAssertEqual(mockFactory.lastPreparedNumber, 2)
    XCTAssertTrue(mockFactory.lastPreparedSide == .shimo)
  }
}

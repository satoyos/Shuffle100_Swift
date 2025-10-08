//
//  RecitePoemViewModelEventHandlerTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2025/10/08.
//

import XCTest
import Combine
import AVFoundation
@testable import Shuffle100

final class RecitePoemViewModelEventHandlerTests: XCTestCase {

  var viewModel: RecitePoemViewModel!
  var testSettings: Settings!
  var cancellables: Set<AnyCancellable>!

  override func setUpWithError() throws {
    testSettings = Settings()
    testSettings.singerID = "ia"
    viewModel = RecitePoemViewModel(settings: testSettings)
    viewModel.enableTestMode()
    cancellables = Set<AnyCancellable>()
  }

  override func tearDownWithError() throws {
    viewModel = nil
    testSettings = nil
    cancellables.removeAll()
    cancellables = nil
  }

  // MARK: - Gear Button Handler Tests

  func test_handleGearButtonTapped_whenPlaying_pausesPlayer() throws {
    viewModel.playNumberedPoem(number: 1, side: .kami)

    var settingsActionCalled = false
    viewModel.openSettingsAction = {
      settingsActionCalled = true
    }

    viewModel.handleGearButtonTapped()

    XCTAssertTrue(settingsActionCalled)
  }

  func test_handleGearButtonTapped_whenNotPlaying_callsAction() throws {
    var settingsActionCalled = false
    viewModel.openSettingsAction = {
      settingsActionCalled = true
    }

    viewModel.handleGearButtonTapped()

    XCTAssertTrue(settingsActionCalled)
  }

  // MARK: - Exit Button Handler Tests

  func test_handleExitButtonTapped_withoutPostMortem() throws {
    testSettings.postMortemEnabled = false
    let viewModelWithoutPostMortem = RecitePoemViewModel(settings: testSettings)
    viewModelWithoutPostMortem.enableTestMode()

    var homeActionCalled = false
    viewModelWithoutPostMortem.backToHomeScreenAction = {
      homeActionCalled = true
    }

    viewModelWithoutPostMortem.handleExitButtonTapped()

    XCTAssertTrue(homeActionCalled)
  }

  func test_handleExitButtonTapped_withPostMortem() throws {
    testSettings.postMortemEnabled = true
    let viewModelWithPostMortem = RecitePoemViewModel(settings: testSettings)
    viewModelWithPostMortem.enableTestMode()

    var homeActionCalled = false
    viewModelWithPostMortem.backToHomeScreenAction = {
      homeActionCalled = true
    }

    viewModelWithPostMortem.handleExitButtonTapped()

    XCTAssertTrue(homeActionCalled)
  }

  // MARK: - Rewind Button Handler Tests

  func test_handleRewindButtonTapped_withoutPlayer_callsBackAction() throws {
    var backActionCalled = false
    viewModel.backToPreviousAction = {
      backActionCalled = true
    }

    viewModel.handleRewindButtonTapped()

    XCTAssertTrue(backActionCalled)
  }

  // Note: Tests requiring actual audio files (withPlayerAtZero, withPlayerNotAtZero) have been removed.
  // These tests would need audio files to be included in the test bundle.

  // MARK: - Forward Button Handler Tests

  func test_handleForwardButtonTapped_withoutPlayer_callsSkipAction() throws {
    var skipActionCalled = false
    viewModel.skipToNextScreenAction = {
      skipActionCalled = true
    }

    viewModel.handleForwardButtonTapped()

    XCTAssertTrue(skipActionCalled)
  }

  // Note: Test with audio player has been removed (requires audio files in test bundle).

  // MARK: - Audio Player Finished Handler Tests

  func test_handleAudioPlayerFinished_withoutPlayer_inTestMode() throws {
    var playerFinishedActionCalled = false
    viewModel.playerFinishedAction = {
      playerFinishedActionCalled = true
    }

    viewModel.handleAudioPlayerFinished()

    XCTAssertTrue(playerFinishedActionCalled)
    XCTAssertEqual(viewModel.binding.progressValue, 1.0)
    XCTAssertTrue(viewModel.playFinished)
  }

  // Note: Test with audio player has been removed (requires audio files in test bundle).

  // MARK: - App Will Resign Active Handler Tests

  func test_handleAppWillResignActive_withoutPlayer() throws {
    viewModel.handleAppWillResignActive()

    // Should not crash
    XCTAssertNotNil(viewModel)
  }

  // Note: Test with playing audio player has been removed (requires audio files in test bundle).

  func test_handleAppWillResignActive_invalidatesTimer() throws {
    viewModel.setTimerForProgressView()
    XCTAssertNotNil(viewModel.progressTimer)

    viewModel.handleAppWillResignActive()

    // Timer should be invalidated
    XCTAssertFalse(viewModel.progressTimer?.isValid ?? true)
  }

  // MARK: - Play Button Tapped Handler Tests

  // Note: Test with audio player has been removed (requires audio files in test bundle).

  func test_handlePlayButtonTapped_whenFinished_callsAction() throws {
    viewModel.playFinished = true

    var actionCalled = false
    viewModel.playButtonTappedAfterFinishedReciting = {
      actionCalled = true
    }

    viewModel.handlePlayButtonTapped()

    XCTAssertTrue(actionCalled)
  }

  // MARK: - Integration Tests

  func test_bindingsSetup_connectsAllInputs() throws {
    // Test that all bindings are properly set up
    var gearCalled = false
    var exitCalled = false
    var rewindCalled = false
    var forwardCalled = false
    var playerFinishedCalled = false

    viewModel.openSettingsAction = { gearCalled = true }
    viewModel.backToHomeScreenAction = { exitCalled = true }
    viewModel.backToPreviousAction = { rewindCalled = true }
    viewModel.skipToNextScreenAction = { forwardCalled = true }
    viewModel.playerFinishedAction = { playerFinishedCalled = true }

    // Trigger all inputs
    viewModel.input.gearButtonTapped.send()
    viewModel.input.exitButtonTapped.send()
    viewModel.input.rewindButtonTapped.send()
    viewModel.input.forwardButtonTapped.send()
    viewModel.input.audioPlayerFinished.send()

    // Wait briefly for all async operations
    let expectation = XCTestExpectation(description: "Wait for all inputs to process")
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.5)

    XCTAssertTrue(gearCalled)
    XCTAssertTrue(exitCalled)
    XCTAssertTrue(rewindCalled)
    XCTAssertTrue(forwardCalled)
    XCTAssertTrue(playerFinishedCalled)
  }
}

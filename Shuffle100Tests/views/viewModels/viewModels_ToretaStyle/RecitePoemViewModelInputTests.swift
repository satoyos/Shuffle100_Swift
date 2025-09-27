//
//  RecitePoemViewModelInputTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2025/09/27.
//

import XCTest
import Combine
@testable import Shuffle100

final class RecitePoemViewModelInputTests: XCTestCase {

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

  // MARK: - Input Event Tests

  func test_gearButtonTapped_triggersAction() throws {
    var actionCalled = false
    viewModel.openSettingsAction = {
      actionCalled = true
    }

    viewModel.input.gearButtonTapped.send()

    XCTAssertTrue(actionCalled)
  }

  func test_exitButtonTapped_triggersAction() throws {
    var actionCalled = false
    viewModel.backToHomeScreenAction = {
      actionCalled = true
    }

    viewModel.input.exitButtonTapped.send()

    XCTAssertTrue(actionCalled)
  }

  func test_rewindButtonTapped_triggersAction() throws {
    var actionCalled = false
    viewModel.backToPreviousAction = {
      actionCalled = true
    }

    viewModel.input.rewindButtonTapped.send()

    XCTAssertTrue(actionCalled)
  }

  func test_forwardButtonTapped_triggersAction() throws {
    var actionCalled = false
    viewModel.skipToNextScreenAction = {
      actionCalled = true
    }

    viewModel.input.forwardButtonTapped.send()

    XCTAssertTrue(actionCalled)
  }

  func test_audioPlayerFinished_triggersAction() throws {
    var actionCalled = false
    viewModel.playerFinishedAction = {
      actionCalled = true
    }

    viewModel.input.audioPlayerFinished.send()

    XCTAssertTrue(actionCalled)
  }

  func test_rapidButtonTaps_handledProperly() throws {
    var actionCallCount = 0
    viewModel.openSettingsAction = {
      actionCallCount += 1
    }

    viewModel.input.gearButtonTapped.send()
    viewModel.input.gearButtonTapped.send()
    viewModel.input.gearButtonTapped.send()

    XCTAssertEqual(actionCallCount, 3)
  }
}
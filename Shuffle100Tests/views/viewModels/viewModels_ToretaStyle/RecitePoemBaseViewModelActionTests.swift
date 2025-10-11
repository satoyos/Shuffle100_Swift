//
//  RecitePoemBaseViewModelActionTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2025/10/11.
//

import XCTest
import Combine
@testable import Shuffle100

final class RecitePoemBaseViewModelActionTests: XCTestCase {

  var viewModel: RecitePoemBaseViewModel!
  var testSettings: Settings!
  var cancellables: Set<AnyCancellable>!

  override func setUpWithError() throws {
    testSettings = Settings()
    testSettings.singerID = "ia"
    viewModel = RecitePoemBaseViewModel(settings: testSettings)
    viewModel.recitePoemViewModel.enableTestMode()
    cancellables = Set<AnyCancellable>()
  }

  override func tearDownWithError() throws {
    viewModel = nil
    testSettings = nil
    cancellables.removeAll()
    cancellables = nil
  }

  // MARK: - Action Forwarding Tests

  func test_playerFinishedAction_isForwarded() throws {
    var baseActionCalled = false

    viewModel.playerFinishedAction = {
      baseActionCalled = true
    }

    // Trigger the action through the child's input
    viewModel.recitePoemViewModel.input.audioPlayerFinished.send()

    XCTAssertTrue(baseActionCalled)
  }

  func test_playButtonTappedAfterFinishedReciting_isForwarded() throws {
    var baseActionCalled = false

    viewModel.playButtonTappedAfterFinishedReciting = {
      baseActionCalled = true
    }

    // Simulate the child action being called
    viewModel.recitePoemViewModel.playButtonTappedAfterFinishedReciting?()

    XCTAssertTrue(baseActionCalled)
  }

  func test_skipToNextScreenAction_isForwarded() throws {
    var baseActionCalled = false

    viewModel.skipToNextScreenAction = {
      baseActionCalled = true
    }

    viewModel.recitePoemViewModel.input.forwardButtonTapped.send()

    XCTAssertTrue(baseActionCalled)
  }
}

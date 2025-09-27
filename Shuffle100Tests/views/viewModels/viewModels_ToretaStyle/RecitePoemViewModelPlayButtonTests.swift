//
//  RecitePoemViewModelPlayButtonTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2025/09/27.
//

import XCTest
import Combine
@testable import Shuffle100

final class RecitePoemViewModelPlayButtonTests: XCTestCase {

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

  // MARK: - Play Button State Tests

  func test_showAsWaitingForPlay() throws {
    // Set initial state to pause by tapping the button (it starts as .play)
    viewModel.playButtonViewModel.input.showAsWaitingFor.send(.pause)

    viewModel.showAsWaitingForPlay()

    XCTAssertEqual(viewModel.playButtonViewModel.output.type, .play)
  }

  func test_showAsWaitingForPause() throws {
    // Initial state is already .play, no need to change
    viewModel.showAsWaitingForPause()

    XCTAssertEqual(viewModel.playButtonViewModel.output.type, .pause)
  }
}
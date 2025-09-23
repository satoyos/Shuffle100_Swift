//
//  RecitePoemViewModelTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2025/09/23.
//

import XCTest
import Combine
@testable import Shuffle100

final class RecitePoemViewModelTests: XCTestCase {

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

  // MARK: - Initialization Tests

  func test_initViewModel() throws {
    XCTAssertEqual(viewModel.output.title, "To be Filled!")
    XCTAssertFalse(viewModel.output.showNormalJokaDesc)
    XCTAssertFalse(viewModel.output.showShortJokaDesc)
    XCTAssertEqual(viewModel.binding.progressValue, 0.0)
    XCTAssertEqual(viewModel.playButtonViewModel.type, .play)
  }

  // MARK: - View Initialization Tests

  func test_initView_setsTitle() throws {
    let testTitle = "テストタイトル"

    viewModel.initView(title: testTitle)

    XCTAssertEqual(viewModel.output.title, testTitle)
  }

  // MARK: - Play Button State Tests

  func test_showAsWaitingForPlay() throws {
    // Set initial state to pause by tapping the button (it starts as .play)
    viewModel.playButtonViewModel.playButtonTapped()

    viewModel.showAsWaitingForPlay()

    XCTAssertEqual(viewModel.playButtonViewModel.type, .play)
  }

  func test_showAsWaitingForPause() throws {
    // Initial state is already .play, no need to change
    viewModel.showAsWaitingForPause()

    XCTAssertEqual(viewModel.playButtonViewModel.type, .pause)
  }

  // MARK: - Joka Description Tests

  func test_addNormalJokaDescLabel() throws {
    viewModel.addNormalJokaDescLabel()

    XCTAssertTrue(viewModel.output.showNormalJokaDesc)
    XCTAssertFalse(viewModel.output.showShortJokaDesc)
  }

  func test_addShortJokaDescLabel() throws {
    viewModel.addShortJokaDescLabel()

    XCTAssertTrue(viewModel.output.showShortJokaDesc)
    XCTAssertFalse(viewModel.output.showNormalJokaDesc)
  }

  func test_hideJokaDescLabels() throws {
    viewModel.addNormalJokaDescLabel()

    viewModel.hideJokaDescLabels()

    XCTAssertFalse(viewModel.output.showNormalJokaDesc)
    XCTAssertFalse(viewModel.output.showShortJokaDesc)
  }

  // MARK: - Screen Transition Tests

  func test_stepIntoNextPoem_updatesTitle() throws {
    let expectation = XCTestExpectation(description: "Title should update")

    viewModel.output.$title
      .dropFirst()
      .sink { title in
        XCTAssertEqual(title, "1首め:上の句 (全10首)")
        expectation.fulfill()
      }
      .store(in: &cancellables)

    viewModel.stepIntoNextPoem(number: 5, at: 1, total: 10, side: .kami)

    wait(for: [expectation], timeout: 1.0)
  }

  func test_stepIntoNextPoem_shimoSide() throws {
    let expectation = XCTestExpectation(description: "Title should update with shimo")

    viewModel.output.$title
      .dropFirst()
      .sink { title in
        XCTAssertEqual(title, "3首め:下の句 (全5首)")
        expectation.fulfill()
      }
      .store(in: &cancellables)

    viewModel.stepIntoNextPoem(number: 25, at: 3, total: 5, side: .shimo)

    wait(for: [expectation], timeout: 1.0)
  }

  func test_slideIntoShimo_updatesTitle() throws {
    let expectation = XCTestExpectation(description: "Title should update")

    viewModel.output.$title
      .dropFirst()
      .sink { title in
        XCTAssertEqual(title, "2首め:下の句 (全7首)")
        expectation.fulfill()
      }
      .store(in: &cancellables)

    viewModel.slideIntoShimo(number: 15, at: 2, total: 7)

    wait(for: [expectation], timeout: 1.0)
  }

  func test_slideBackToKami_updatesTitle() throws {
    let expectation = XCTestExpectation(description: "Title should update")

    viewModel.output.$title
      .dropFirst()
      .sink { title in
        XCTAssertEqual(title, "4首め:上の句 (全8首)")
        expectation.fulfill()
      }
      .store(in: &cancellables)

    viewModel.slideBackToKami(number: 33, at: 4, total: 8)

    wait(for: [expectation], timeout: 1.0)
  }

  func test_goBackToPrevPoem_updatesTitle() throws {
    let expectation = XCTestExpectation(description: "Title should update")

    viewModel.output.$title
      .dropFirst()
      .sink { title in
        XCTAssertEqual(title, "1首め:下の句 (全3首)")
        expectation.fulfill()
      }
      .store(in: &cancellables)

    viewModel.goBackToPrevPoem(number: 77, at: 1, total: 3)

    wait(for: [expectation], timeout: 1.0)
  }

  func test_stepIntoGameEnd_updatesTitle() throws {
    let expectation = XCTestExpectation(description: "Title should update to game end")

    viewModel.output.$title
      .dropFirst()
      .sink { title in
        XCTAssertEqual(title, "試合終了")
        expectation.fulfill()
      }
      .store(in: &cancellables)

    viewModel.stepIntoGameEnd()

    wait(for: [expectation], timeout: 1.0)
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

  // MARK: - Settings Integration Tests

  func test_initWithDifferentSinger() throws {
    testSettings.singerID = "inaba"
    let viewModelWithInaba = RecitePoemViewModel(settings: testSettings)

    // Should not crash and should initialize properly
    XCTAssertNotNil(viewModelWithInaba)
    XCTAssertEqual(viewModelWithInaba.output.title, "To be Filled!")
  }

  func test_volumeSettingIntegration() throws {
    testSettings.volume = 0.7
    let viewModelWithVolume = RecitePoemViewModel(settings: testSettings)

    // Should use the volume setting from settings
    XCTAssertNotNil(viewModelWithVolume)
  }

  // MARK: - Edge Cases

  func test_multipleJokaDescLabels_onlyOneShown() throws {
    viewModel.addNormalJokaDescLabel()
    viewModel.addShortJokaDescLabel()

    // Only short should be shown (last one wins)
    XCTAssertFalse(viewModel.output.showNormalJokaDesc)
    XCTAssertTrue(viewModel.output.showShortJokaDesc)
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
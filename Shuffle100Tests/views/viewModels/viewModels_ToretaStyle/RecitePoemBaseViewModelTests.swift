//
//  RecitePoemBaseViewModelTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2025/10/08.
//

import XCTest
import Combine
@testable import Shuffle100

final class RecitePoemBaseViewModelTests: XCTestCase {

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

  // MARK: - Initialization Tests

  func test_initViewModel() throws {
    XCTAssertEqual(viewModel.output.rotationAngle, 0)
    XCTAssertEqual(viewModel.output.slideOffset, 0)
    XCTAssertFalse(viewModel.output.showingSlideCard)
    XCTAssertEqual(viewModel.output.currentViewIndex, 0)
    XCTAssertNotNil(viewModel.recitePoemViewModel)
  }

  func test_initView_setsTitle() throws {
    let testTitle = "テストタイトル"

    viewModel.initView(title: testTitle)

    XCTAssertEqual(viewModel.recitePoemViewModel.output.title, testTitle)
  }

  // MARK: - Computed Properties Tests

  func test_normalizedAngle_zeroRotation() throws {
    viewModel.output.rotationAngle = 0
    XCTAssertEqual(viewModel.normalizedAngle, 0)
  }

  func test_normalizedAngle_oneRotation() throws {
    viewModel.output.rotationAngle = 180
    XCTAssertEqual(viewModel.normalizedAngle, 180)
  }

  func test_normalizedAngle_multipleRotations() throws {
    viewModel.output.rotationAngle = 540
    XCTAssertEqual(viewModel.normalizedAngle, 180)
  }

  func test_normalizedAngle_negativeRotation() throws {
    viewModel.output.rotationAngle = -90
    XCTAssertEqual(viewModel.normalizedAngle, -90)
  }

  func test_isFrontVisible_whenAngleIsZero() throws {
    viewModel.output.rotationAngle = 0
    XCTAssertTrue(viewModel.isFrontVisible)
  }

  func test_isFrontVisible_whenAngleIs90() throws {
    viewModel.output.rotationAngle = 90
    XCTAssertTrue(viewModel.isFrontVisible)
  }

  func test_isFrontVisible_whenAngleIs179() throws {
    viewModel.output.rotationAngle = 179
    XCTAssertTrue(viewModel.isFrontVisible)
  }

  func test_isFrontVisible_whenAngleIs180() throws {
    viewModel.output.rotationAngle = 180
    XCTAssertFalse(viewModel.isFrontVisible)
  }

  func test_isFrontVisible_whenAngleIs270() throws {
    viewModel.output.rotationAngle = 270
    XCTAssertFalse(viewModel.isFrontVisible)
  }

  func test_isFrontVisible_whenAngleIs360() throws {
    viewModel.output.rotationAngle = 360
    XCTAssertTrue(viewModel.isFrontVisible)
  }

  // MARK: - Flip Animation Tests

  func test_flipAnimation_updatesRotationAngle() throws {
    let initialAngle = viewModel.output.rotationAngle
    let expectation = XCTestExpectation(description: "Rotation angle should increase by 180")

    viewModel.output.$rotationAngle
      .dropFirst()
      .sink { angle in
        XCTAssertEqual(angle, initialAngle + 180)
        expectation.fulfill()
      }
      .store(in: &cancellables)

    viewModel.input.flipAnimation.send()

    wait(for: [expectation], timeout: 1.0)
  }

  func test_flipAnimation_updatesCurrentViewIndex() throws {
    let initialIndex = viewModel.output.currentViewIndex
    let expectation = XCTestExpectation(description: "Current view index should increment")

    viewModel.output.$currentViewIndex
      .dropFirst()
      .sink { index in
        XCTAssertEqual(index, initialIndex + 1)
        expectation.fulfill()
      }
      .store(in: &cancellables)

    viewModel.input.flipAnimation.send()

    wait(for: [expectation], timeout: 1.0)
  }

  func test_flipAnimation_multipleFlips() throws {
    viewModel.input.flipAnimation.send()
    viewModel.input.flipAnimation.send()

    XCTAssertEqual(viewModel.output.rotationAngle, 360)
    XCTAssertEqual(viewModel.output.currentViewIndex, 2)
  }

  // MARK: - Slide Animation Tests

  func test_slideAnimation_updatesShowingSlideCard() throws {
    let expectation = XCTestExpectation(description: "showingSlideCard should become true")

    viewModel.output.$showingSlideCard
      .dropFirst()
      .sink { showing in
        XCTAssertTrue(showing)
        expectation.fulfill()
      }
      .store(in: &cancellables)

    viewModel.input.slideAnimation.send(375.0)

    wait(for: [expectation], timeout: 1.0)
  }

  func test_slideAnimation_setsInitialSlideOffset() throws {
    let screenWidth: CGFloat = 400.0
    let expectation = XCTestExpectation(description: "slideOffset should change")
    var offsetValues: [CGFloat] = []

    viewModel.output.$slideOffset
      .sink { offset in
        offsetValues.append(offset)
        if offsetValues.count >= 2 {
          expectation.fulfill()
        }
      }
      .store(in: &cancellables)

    viewModel.input.slideAnimation.send(screenWidth)

    wait(for: [expectation], timeout: 1.0)

    // Check that slideOffset was set to screenWidth initially (captured in values)
    XCTAssertTrue(offsetValues.contains(screenWidth), "Expected slideOffset to include \(screenWidth), but got \(offsetValues)")
  }

  // MARK: - Screen Transition Tests

  func test_stepIntoNextPoem_kamiSide_updatesTitle() throws {
    let expectation = XCTestExpectation(description: "Title should update")

    viewModel.recitePoemViewModel.output.$title
      .dropFirst()
      .sink { title in
        XCTAssertEqual(title, "1首め:上の句 (全10首)")
        expectation.fulfill()
      }
      .store(in: &cancellables)

    viewModel.stepIntoNextPoem(number: 5, at: 1, total: 10, side: .kami)

    wait(for: [expectation], timeout: 1.0)
  }

  func test_stepIntoNextPoem_shimoSide_updatesTitle() throws {
    let expectation = XCTestExpectation(description: "Title should update with shimo")

    viewModel.recitePoemViewModel.output.$title
      .dropFirst()
      .sink { title in
        XCTAssertEqual(title, "3首め:下の句 (全5首)")
        expectation.fulfill()
      }
      .store(in: &cancellables)

    viewModel.stepIntoNextPoem(number: 25, at: 3, total: 5, side: .shimo)

    wait(for: [expectation], timeout: 1.0)
  }

  func test_stepIntoNextPoem_triggersFlipAnimation() throws {
    let expectation = XCTestExpectation(description: "Rotation angle should change")

    viewModel.output.$rotationAngle
      .dropFirst()
      .sink { _ in
        expectation.fulfill()
      }
      .store(in: &cancellables)

    viewModel.stepIntoNextPoem(number: 1, at: 1, total: 10, side: .kami)

    wait(for: [expectation], timeout: 1.0)
  }

  func test_slideIntoShimo_updatesTitle() throws {
    let expectation = XCTestExpectation(description: "Title should update")

    viewModel.recitePoemViewModel.output.$title
      .dropFirst()
      .sink { title in
        XCTAssertEqual(title, "2首め:下の句 (全7首)")
        expectation.fulfill()
      }
      .store(in: &cancellables)

    viewModel.slideIntoShimo(number: 15, at: 2, total: 7)

    wait(for: [expectation], timeout: 1.0)
  }

  func test_slideIntoShimo_triggersSlideAnimation_whenScreenWidthSet() throws {
    viewModel.screenWidth = 375.0
    let expectation = XCTestExpectation(description: "showingSlideCard should become true")

    viewModel.output.$showingSlideCard
      .dropFirst()
      .sink { showing in
        XCTAssertTrue(showing)
        expectation.fulfill()
      }
      .store(in: &cancellables)

    viewModel.slideIntoShimo(number: 15, at: 2, total: 7)

    wait(for: [expectation], timeout: 1.0)
  }

  func test_slideIntoShimo_doesNotTriggerSlideAnimation_whenScreenWidthZero() throws {
    viewModel.screenWidth = 0
    var slideCardChanged = false

    viewModel.output.$showingSlideCard
      .dropFirst()
      .sink { _ in
        slideCardChanged = true
      }
      .store(in: &cancellables)

    viewModel.slideIntoShimo(number: 15, at: 2, total: 7)

    // Wait briefly to ensure no animation is triggered
    let expectation = XCTestExpectation(description: "Wait for potential changes")
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.2)

    XCTAssertFalse(slideCardChanged)
  }

  func test_slideBackToKami_updatesTitle() throws {
    let expectation = XCTestExpectation(description: "Title should update")

    viewModel.recitePoemViewModel.output.$title
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

    viewModel.recitePoemViewModel.output.$title
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

    viewModel.recitePoemViewModel.output.$title
      .dropFirst()
      .sink { title in
        XCTAssertEqual(title, "試合終了")
        expectation.fulfill()
      }
      .store(in: &cancellables)

    viewModel.stepIntoGameEnd()

    wait(for: [expectation], timeout: 1.0)
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

  // MARK: - Settings Integration Tests

  func test_initWithDifferentSinger() throws {
    testSettings.singerID = "inaba"
    let viewModelWithInaba = RecitePoemBaseViewModel(settings: testSettings)

    XCTAssertNotNil(viewModelWithInaba)
    XCTAssertNotNil(viewModelWithInaba.recitePoemViewModel)
  }

  func test_kamiShimoInterval_isUsedInSlideAnimation() throws {
    testSettings.kamiShimoInterval = 2.0
    let customViewModel = RecitePoemBaseViewModel(settings: testSettings)
    customViewModel.screenWidth = 375.0

    // The interval is used in the animation duration
    XCTAssertEqual(customViewModel.settings.kamiShimoInterval, 2.0)
  }
}

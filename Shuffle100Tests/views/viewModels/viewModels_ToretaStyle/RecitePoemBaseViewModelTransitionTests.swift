//
//  RecitePoemBaseViewModelTransitionTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2025/10/11.
//

import XCTest
import Combine
@testable import Shuffle100

final class RecitePoemBaseViewModelTransitionTests: XCTestCase {

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
    let initialAngle = viewModel.output.rotationAngle
    let expectation = XCTestExpectation(description: "Rotation angle should increase by 180")

    viewModel.output.$rotationAngle
      .dropFirst()
      .sink { angle in
        XCTAssertEqual(angle, initialAngle + 180)
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
}

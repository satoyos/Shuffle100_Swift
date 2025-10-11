//
//  RecitePoemBaseViewModelAnimationTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2025/10/11.
//

import XCTest
import Combine
@testable import Shuffle100

final class RecitePoemBaseViewModelAnimationTests: XCTestCase {

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
}

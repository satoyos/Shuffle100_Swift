//
//  RecitePoemViewModelNavigationTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2025/09/27.
//

import XCTest
import Combine
@testable import Shuffle100

final class RecitePoemViewModelNavigationTests: XCTestCase {

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
}
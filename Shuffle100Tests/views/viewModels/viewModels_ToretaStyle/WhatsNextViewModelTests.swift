//
//  WhatsNextViewModelTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2025/10/19.
//

@testable import Shuffle100
import XCTest
import Combine

final class WhatsNextViewModelTests: XCTestCase {
  private var cancellables: Set<AnyCancellable> = []

  // MARK: - Initialization Tests

  func testInit() throws {
    // given
    let poem = createTestPoem(number: 1)
    // when
    let viewModel = WhatsNextViewModel(currentPoem: poem)
    // then
    XCTAssertNotNil(viewModel)
    XCTAssertEqual(viewModel.output.currentPoem.number, 1)
    XCTAssertFalse(viewModel.binding.showExitConfirmation)
  }

  // MARK: - Button Action Tests

  func testTorifudaButtonTappedCallsAction() throws {
    // given
    let poem = createTestPoem(number: 1)
    let viewModel = WhatsNextViewModel(currentPoem: poem)
    var actionCalled = false
    viewModel.showTorifudaAction = {
      actionCalled = true
    }
    // when
    viewModel.input.torifudaButtonTapped.send()
    // then
    XCTAssertTrue(actionCalled)
  }

  func testRefrainButtonTappedCallsAction() throws {
    // given
    let poem = createTestPoem(number: 2)
    let viewModel = WhatsNextViewModel(currentPoem: poem)
    var actionCalled = false
    viewModel.refrainAction = {
      actionCalled = true
    }
    // when
    viewModel.input.refrainButtonTapped.send()
    // then
    XCTAssertTrue(actionCalled)
  }

  func testGoNextButtonTappedCallsAction() throws {
    // given
    let poem = createTestPoem(number: 3)
    let viewModel = WhatsNextViewModel(currentPoem: poem)
    var actionCalled = false
    viewModel.goNextAction = {
      actionCalled = true
    }
    // when
    viewModel.input.goNextButtonTapped.send()
    // then
    XCTAssertTrue(actionCalled)
  }

  func testGearButtonTappedCallsAction() throws {
    // given
    let poem = createTestPoem(number: 4)
    let viewModel = WhatsNextViewModel(currentPoem: poem)
    var actionCalled = false
    viewModel.goSettingAction = {
      actionCalled = true
    }
    // when
    viewModel.input.gearButtonTapped.send()
    // then
    XCTAssertTrue(actionCalled)
  }

  func testExitButtonTappedShowsConfirmation() throws {
    // given
    let poem = createTestPoem(number: 5)
    let viewModel = WhatsNextViewModel(currentPoem: poem)
    let expectation = XCTestExpectation(description: "Exit confirmation dialog should show")
    // then
    XCTAssertFalse(viewModel.binding.showExitConfirmation)

    viewModel.binding.$showExitConfirmation
      .dropFirst()
      .sink { showConfirmation in
        XCTAssertTrue(showConfirmation)
        expectation.fulfill()
      }
      .store(in: &cancellables)

    // when
    viewModel.input.exitButtonTapped.send()

    // then
    wait(for: [expectation], timeout: 0.1)
  }

  func testBackToHomeActionCalled() throws {
    // given
    let poem = createTestPoem(number: 6)
    let viewModel = WhatsNextViewModel(currentPoem: poem)
    var actionCalled = false
    viewModel.backToHomeScreenAction = {
      actionCalled = true
    }
    // when (simulate user confirming exit)
    viewModel.backToHomeScreenAction?()
    // then
    XCTAssertTrue(actionCalled)
  }

  // MARK: - State Tests

  func testCurrentPoemIsPreserved() throws {
    // given
    let poem = createTestPoem(number: 42)
    // when
    let viewModel = WhatsNextViewModel(currentPoem: poem)
    // then
    XCTAssertEqual(viewModel.output.currentPoem.number, 42)
    XCTAssertEqual(viewModel.output.currentPoem.poet, "Test Poet")
  }

  // MARK: - Multiple Actions Tests

  func testMultipleActionsDontInterfere() throws {
    // given
    let poem = createTestPoem(number: 7)
    let viewModel = WhatsNextViewModel(currentPoem: poem)
    var torifudaCallCount = 0
    var refrainCallCount = 0
    viewModel.showTorifudaAction = {
      torifudaCallCount += 1
    }
    viewModel.refrainAction = {
      refrainCallCount += 1
    }
    // when
    viewModel.input.torifudaButtonTapped.send()
    viewModel.input.refrainButtonTapped.send()
    viewModel.input.torifudaButtonTapped.send()
    // then
    XCTAssertEqual(torifudaCallCount, 2)
    XCTAssertEqual(refrainCallCount, 1)
  }

  // MARK: - Helper Methods

  private func createTestPoem(number: Int) -> Poem {
    return Poem(
      number: number,
      poet: "Test Poet",
      living_years: "1000-1100",
      liner: ["Line 1", "Line 2", "Line 3", "Line 4", "Line 5"],
      in_hiragana: Liner2Parts(
        kami: "かみのく",
        shimo: "しものく"
      ),
      in_modern_kana: ["ライン1", "ライン2", "ライン3", "ライン4", "ライン5"],
      kimari_ji: "かみ"
    )
  }
}

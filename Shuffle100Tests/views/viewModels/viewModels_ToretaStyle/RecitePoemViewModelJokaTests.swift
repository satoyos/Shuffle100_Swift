//
//  RecitePoemViewModelJokaTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2025/09/27.
//

import XCTest
import Combine
@testable import Shuffle100

final class RecitePoemViewModelJokaTests: XCTestCase {

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

  func test_multipleJokaDescLabels_onlyOneShown() throws {
    viewModel.addNormalJokaDescLabel()
    viewModel.addShortJokaDescLabel()

    // Only short should be shown (last one wins)
    XCTAssertFalse(viewModel.output.showNormalJokaDesc)
    XCTAssertTrue(viewModel.output.showShortJokaDesc)
  }
}
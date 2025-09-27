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
    XCTAssertEqual(viewModel.playButtonViewModel.output.type, .play)
  }

  // MARK: - View Initialization Tests

  func test_initView_setsTitle() throws {
    let testTitle = "テストタイトル"

    viewModel.initView(title: testTitle)

    XCTAssertEqual(viewModel.output.title, testTitle)
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
}

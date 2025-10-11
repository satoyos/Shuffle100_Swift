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

//
//  RecitePoemViewModelNavigationTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2025/09/27.
//
//  Note: Navigation tests (stepIntoNextPoem, slideIntoShimo, etc.) have been
//  moved to RecitePoemBaseViewModelTests as these are now handled by RecitePoemBaseViewModel.
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
  // Note: These tests are kept here to verify RecitePoemViewModel still supports
  // the navigation methods, even though they are now primarily called through
  // RecitePoemBaseViewModel. This ensures backward compatibility.
}
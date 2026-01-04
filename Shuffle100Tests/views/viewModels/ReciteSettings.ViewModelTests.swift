//
//  ReciteSettings.ViewModelTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2026/01/04.
//  Copyright © 2026 里 佳史. All rights reserved.
//

import XCTest
@testable import Shuffle100

@MainActor
class ReciteSettingsViewModelTests: XCTestCase {

  func test_sectionsCount() {
    let settings = Settings()
    let store = StoreManager()
    let viewModel = ReciteSettings.ViewModel(settings: settings, store: store)

    XCTAssertEqual(viewModel.sections.count, 2)
  }

  func test_intervalSectionHasTwoRows() {
    let settings = Settings()
    let store = StoreManager()
    let viewModel = ReciteSettings.ViewModel(settings: settings, store: store)

    XCTAssertEqual(viewModel.sections[0].title, "読み上げの間隔")
    XCTAssertEqual(viewModel.sections[0].rows.count, 2)
  }

  func test_volumeSectionHasOneRow() {
    let settings = Settings()
    let store = StoreManager()
    let viewModel = ReciteSettings.ViewModel(settings: settings, store: store)

    XCTAssertEqual(viewModel.sections[1].title, "音量")
    XCTAssertEqual(viewModel.sections[1].rows.count, 1)
  }

  func test_intervalValue_formattedCorrectly() {
    let settings = Settings()
    settings.interval = 1.10
    let store = StoreManager()
    let viewModel = ReciteSettings.ViewModel(settings: settings, store: store)

    XCTAssertEqual(viewModel.sections[0].rows[0].value, "1.10秒")
  }

  func test_kamiShimoIntervalValue_formattedCorrectly() {
    let settings = Settings()
    settings.kamiShimoInterval = 1.00
    let store = StoreManager()
    let viewModel = ReciteSettings.ViewModel(settings: settings, store: store)

    XCTAssertEqual(viewModel.sections[0].rows[1].value, "1.00秒")
  }

  func test_volumeValue_formattedCorrectly() {
    let settings = Settings()
    settings.volume = 1.0
    let store = StoreManager()
    let viewModel = ReciteSettings.ViewModel(settings: settings, store: store)

    XCTAssertEqual(viewModel.sections[1].rows[0].value, "100%")
  }

  func test_shortenJokaBinding_updatesSettingsImmediately() {
    let settings = Settings()
    let store = StoreManager()
    let viewModel = ReciteSettings.ViewModel(settings: settings, store: store)

    let binding = viewModel.shortenJokaBinding
    binding.wrappedValue = true

    XCTAssertTrue(viewModel.shortenJoka)
    XCTAssertTrue(settings.shortenJoka)
  }

  func test_postMortemEnabledBinding_updatesSettingsImmediately() {
    let settings = Settings()
    let store = StoreManager()
    let viewModel = ReciteSettings.ViewModel(settings: settings, store: store)

    let binding = viewModel.postMortemEnabledBinding
    binding.wrappedValue = true

    XCTAssertTrue(viewModel.postMortemEnabled)
    XCTAssertTrue(settings.postMortemEnabled)
  }

  func test_refreshSections_updatesValuesFromSettings() {
    let settings = Settings()
    settings.interval = 1.10
    let store = StoreManager()
    let viewModel = ReciteSettings.ViewModel(settings: settings, store: store)

    // 設定値を変更
    settings.interval = 2.00

    // refreshを呼び出し
    viewModel.refreshSections()

    // 表示値が更新されていることを確認
    XCTAssertEqual(viewModel.sections[0].rows[0].value, "2.00秒")
  }
}

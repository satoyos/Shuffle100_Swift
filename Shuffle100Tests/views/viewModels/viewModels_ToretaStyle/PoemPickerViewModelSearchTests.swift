//
//  PoemPickerViewModelSearchTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2025/08/17.
//  Copyright © 2025 里 佳史. All rights reserved.
//

import XCTest
import Combine
@testable import Shuffle100

class PoemPickerViewModelSearchTests: XCTestCase {

  var viewModel: PoemPickerView.ViewModel!
  var testSettings: Settings!
  var cancellables: Set<AnyCancellable> = []

  override func setUpWithError() throws {
    testSettings = Settings(bool100: Bool100.allUnselected, savedFudaSets: [])
    viewModel = PoemPickerView.ViewModel(settings: testSettings)
  }

  override func tearDownWithError() throws {
    viewModel = nil
    testSettings = nil
    cancellables.removeAll()
  }

  // MARK: - Search Tests

  func test_searchText_emptySearch() throws {
    // when
    viewModel.binding.searchText = ""

    // then
    XCTAssertEqual(viewModel.binding.searchText, "")
    XCTAssertFalse(viewModel.output.isSearching)
    XCTAssertEqual(viewModel.output.filteredPoems.count, 100)
    XCTAssertEqual(viewModel.output.filteredPoems, PoemSupplier.originalPoems)
  }

  func test_searchText_validSearch() throws {
    // when - "春" で検索
    viewModel.binding.searchText = "春"

    // then
    XCTAssertEqual(viewModel.binding.searchText, "春")
    XCTAssertTrue(viewModel.output.isSearching)
    XCTAssertEqual(viewModel.output.filteredPoems.count, 6)

    // 検索結果の妥当性確認
    for poem in viewModel.output.filteredPoems {
      XCTAssertTrue(poem.searchText.contains("春"))
    }
  }

  func test_searchText_caseInsensitive() throws {
    // when - 大文字小文字の違いでの検索
    viewModel.binding.searchText = "HARU"
    let upperCaseResults = viewModel.output.filteredPoems

    viewModel.binding.searchText = "haru"
    let lowerCaseResults = viewModel.output.filteredPoems

    // then - 大文字小文字に関係なく同じ結果
    XCTAssertEqual(upperCaseResults.count, lowerCaseResults.count)
    XCTAssertEqual(upperCaseResults.map(\.number), lowerCaseResults.map(\.number))
  }

  func test_searchText_noResults() throws {
    // when - 存在しない文字列で検索
    viewModel.binding.searchText = "存在しない検索語"

    // then
    XCTAssertEqual(viewModel.binding.searchText, "存在しない検索語")
    XCTAssertTrue(viewModel.output.isSearching)
    XCTAssertEqual(viewModel.output.filteredPoems.count, 0)
  }

  func test_searchText_clearSearch() throws {
    // given - 予め検索しておく
    viewModel.binding.searchText = "春"
    XCTAssertTrue(viewModel.output.isSearching)
    XCTAssertEqual(viewModel.output.filteredPoems.count, 6)

    // when - 検索をクリア
    viewModel.binding.searchText = ""

    // then
    XCTAssertEqual(viewModel.binding.searchText, "")
    XCTAssertFalse(viewModel.output.isSearching)
    XCTAssertEqual(viewModel.output.filteredPoems.count, 100)
  }

  // MARK: - refreshFromSettings Tests

  func test_refreshFromSettings_updatesSelectedCount() throws {
    // given - 初期状態のViewModelと外部でのsettings変更
    let initialSelectedCount = viewModel.output.selectedCount
    XCTAssertEqual(initialSelectedCount, 0) // allUnselectedで初期化されている

    // settings.state100を外部で変更（他の画面での操作を模擬）
    var newState = testSettings.state100
    newState = newState.reverseInNumber(1)  // 1番を選択
    newState = newState.reverseInNumber(25) // 25番を選択
    newState = newState.reverseInNumber(93) // 93番を選択
    testSettings.state100 = newState

    // ViewModelは外部変更をまだ知らない
    XCTAssertEqual(viewModel.output.selectedCount, initialSelectedCount)

    // when - refreshFromSettings()を呼び出し
    viewModel.refreshFromSettings()

    // then - output.selectedCountが更新されている
    XCTAssertEqual(viewModel.output.selectedCount, 3)
    XCTAssertEqual(viewModel.output.selectedCount, testSettings.state100.selectedNum)
  }

  func test_refreshFromSettings_multipleUpdates() throws {
    // given - 初期状態
    XCTAssertEqual(viewModel.output.selectedCount, 0)

    // when/then - 段階的な変更とrefresh

    // 第1段階: 10首選択
    var newState = testSettings.state100
    for i in 1...10 {
      newState = newState.reverseInNumber(i)
    }
    testSettings.state100 = newState
    viewModel.refreshFromSettings()
    XCTAssertEqual(viewModel.output.selectedCount, 10)

    // 第2段階: さらに5首追加選択
    for i in 11...15 {
      newState = newState.reverseInNumber(i)
    }
    testSettings.state100 = newState
    viewModel.refreshFromSettings()
    XCTAssertEqual(viewModel.output.selectedCount, 15)

    // 第3段階: 3首選択解除
    for i in [1, 5, 10] {
      newState = newState.reverseInNumber(i)
    }
    testSettings.state100 = newState
    viewModel.refreshFromSettings()
    XCTAssertEqual(viewModel.output.selectedCount, 12)

    // 第4段階: 全選択
    newState = newState.selectAll()
    testSettings.state100 = newState
    viewModel.refreshFromSettings()
    XCTAssertEqual(viewModel.output.selectedCount, 100)

    // 第5段階: 全取消
    newState = newState.cancelAll()
    testSettings.state100 = newState
    viewModel.refreshFromSettings()
    XCTAssertEqual(viewModel.output.selectedCount, 0)
  }
}
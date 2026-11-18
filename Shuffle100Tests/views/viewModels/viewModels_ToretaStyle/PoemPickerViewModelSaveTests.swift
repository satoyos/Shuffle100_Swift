//
//  PoemPickerViewModelSaveTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2025/08/17.
//  Copyright © 2025 里 佳史. All rights reserved.
//

import XCTest
import Combine
@testable import Shuffle100

class PoemPickerViewModelSaveTests: XCTestCase {

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

  // MARK: - Save Set Alert Tests

  func test_prepareSave_returnsEmptySetAlertWhenNoPoems() throws {
    // given - 歌が選択されていない状態
    viewModel.input.cancelAll.send()
    XCTAssertEqual(viewModel.output.selectedCount, 0)
    // when
    let action = viewModel.prepareSave()

    // then
    XCTAssertEqual(action, .showEmptySetAlert)
  }

  func test_prepareSave_returnsActionSheetWhenPoemsSelected() throws {
    // given - 歌が選択されている状態
    viewModel.input.selectPoem.send(1)
    viewModel.input.selectPoem.send(15)
    viewModel.input.selectPoem.send(42)
    XCTAssertEqual(viewModel.output.selectedCount, 3)
    // when
    let action = viewModel.prepareSave()

    // then
    XCTAssertEqual(action, .showActionSheet)
  }

  // MARK: - New Fuda Set Name Tests

  func test_saveNewFudaSet_showsAlertWhenNameIsEmpty() throws {
    // given - 歌を選択済み状態で、空の札セット名を設定
    viewModel.input.selectPoem.send(1)
    viewModel.input.selectPoem.send(25)
    XCTAssertEqual(viewModel.output.selectedCount, 2)

    let initialFudaSetsCount = testSettings.savedFudaSets.count
    // when
    let result = viewModel.saveNewFudaSet(name: "")

    // then
    XCTAssertTrue(result.successMessage.isEmpty)
    XCTAssertTrue(result.alertTitle.isEmpty)
    XCTAssertEqual(testSettings.savedFudaSets.count, initialFudaSetsCount, "札セットは追加されない")
  }

  func test_saveNewFudaSet_showsAlertWhenNameIsWhitespaceOnly() throws {
    // given - 歌を選択済み状態で、空白のみの札セット名を設定
    viewModel.input.selectPoem.send(10)
    XCTAssertEqual(viewModel.output.selectedCount, 1)

    let initialFudaSetsCount = testSettings.savedFudaSets.count
    // when
    let result = viewModel.saveNewFudaSet(name: "   \t\n  ")

    // then
    XCTAssertTrue(result.successMessage.isEmpty)
    XCTAssertTrue(result.alertTitle.isEmpty)
    XCTAssertEqual(testSettings.savedFudaSets.count, initialFudaSetsCount, "札セットは追加されない")
  }

  func test_saveNewFudaSet_succedsWithValidName() throws {
    // given - 歌を選択済み状態で、有効な札セット名を設定
    viewModel.input.selectPoem.send(5)
    viewModel.input.selectPoem.send(50)
    viewModel.input.selectPoem.send(95)
    XCTAssertEqual(viewModel.output.selectedCount, 3)

    let initialFudaSetsCount = testSettings.savedFudaSets.count
    let validName = "テスト札セット"

    // when
    let result = viewModel.saveNewFudaSet(name: validName)

    // then
    XCTAssertEqual(testSettings.savedFudaSets.count, initialFudaSetsCount + 1, "札セットが追加される")
    XCTAssertEqual(testSettings.savedFudaSets.last?.name, validName, "札セット名が正しく設定される")
    XCTAssertEqual(result.alertTitle, "保存完了")
    XCTAssertEqual(result.successMessage, "新しい札セット「\(validName)」を保存しました。")
  }

  func test_saveNewFudaSet_trimsWhitespaceFromValidName() throws {
    // given - 歌を選択済み状態で、前後に空白がある有効な札セット名を設定
    viewModel.input.selectPoem.send(33)
    XCTAssertEqual(viewModel.output.selectedCount, 1)

    let initialFudaSetsCount = testSettings.savedFudaSets.count
    let nameWithWhitespace = "  春の札セット  \n"
    let expectedTrimmedName = "春の札セット"

    // when
    let result = viewModel.saveNewFudaSet(name: nameWithWhitespace)

    // then
    XCTAssertEqual(testSettings.savedFudaSets.count, initialFudaSetsCount + 1, "札セットが追加される")
    XCTAssertEqual(testSettings.savedFudaSets.last?.name, expectedTrimmedName, "札セット名から空白が削除されて設定される")
    XCTAssertEqual(result.successMessage, "新しい札セット「\(expectedTrimmedName)」を保存しました。")
  }

  // MARK: - Integration Tests

  func test_searchAndSelect_integration() throws {
    // given - "春"で検索
    viewModel.binding.searchText = "春"
    let searchResults = viewModel.output.filteredPoems
    XCTAssertEqual(searchResults.count, 6)

    // when - 検索結果の最初の歌を選択
    let firstPoemNumber = searchResults[0].number
    let initialSelectedCount = viewModel.output.selectedCount
    viewModel.input.selectPoem.send(firstPoemNumber)

    // then
    XCTAssertTrue(viewModel.isPoemSelected(firstPoemNumber))
    XCTAssertEqual(viewModel.output.selectedCount, initialSelectedCount + 1)

    // when - 検索をクリア
    viewModel.binding.searchText = ""

    // then - 選択状態は維持される
    XCTAssertFalse(viewModel.output.isSearching)
    XCTAssertEqual(viewModel.output.filteredPoems.count, 100)
    XCTAssertTrue(viewModel.isPoemSelected(firstPoemNumber))
  }

  func test_multipleOperations_integration() throws {
    // given
    let initialCount = viewModel.output.selectedCount

    // when - 複数の操作を順次実行
    viewModel.input.selectPoem.send(2)  // 1首選択
    viewModel.input.selectPoem.send(20)  // 2首目選択
    viewModel.binding.searchText = "春" // 検索
    viewModel.input.selectPoem.send(2)  // 1首目選択解除
    viewModel.binding.searchText = ""  // 検索クリア

    // then
    XCTAssertFalse(viewModel.isPoemSelected(2))  // 選択解除済み
    XCTAssertTrue(viewModel.isPoemSelected(20))   // 選択維持
    XCTAssertFalse(viewModel.output.isSearching)  // 検索状態クリア
    XCTAssertEqual(viewModel.output.filteredPoems.count, 100)  // 全歌表示
    XCTAssertEqual(viewModel.output.selectedCount, initialCount + 1)  // 1首増加
  }

  func test_combinePublishers_behavesCorrectly() throws {
    // given
    var receivedSelectedCounts: [Int] = []

    // Outputの変更を監視
    viewModel.output.$selectedCount
      .sink { count in
        receivedSelectedCounts.append(count)
      }
      .store(in: &cancellables)

    // when - selectPoem の sink は同期的に selectedCount を更新するため、
    // PassthroughSubject.send() を直接呼べば即座に sink へ伝搬する。
    viewModel.input.selectPoem.send(1)   // +1
    viewModel.input.selectPoem.send(2)   // +1
    viewModel.input.selectPoem.send(1)   // -1 (選択解除)

    // then
    XCTAssertEqual(receivedSelectedCounts.count, 4)
    // 初期値、+1、+1、-1の順序で変更されることを確認
    XCTAssertEqual(receivedSelectedCounts[1], receivedSelectedCounts[0] + 1)
    XCTAssertEqual(receivedSelectedCounts[2], receivedSelectedCounts[1] + 1)
    XCTAssertEqual(receivedSelectedCounts[3], receivedSelectedCounts[2] - 1)
  }
}

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

  func test_saveSet_showsEmptySetAlertWhenNoPoems() throws {
    // given - 歌が選択されていない状態
    viewModel.input.cancelAll.send()
    XCTAssertEqual(viewModel.output.selectedCount, 0)
    XCTAssertFalse(viewModel.binding.showEmptySetAlert)

    // when - 保存を試行
    viewModel.input.saveSet.send()

    // then - 空札セットアラートが表示される準備ができている
    XCTAssertTrue(viewModel.binding.showEmptySetAlert, "空札セット保存時にshowEmptySetAlertがtrueになるべき")
    XCTAssertFalse(viewModel.binding.showSaveActionSheet, "空札セット時は保存アクションシートは表示されない")
  }

  func test_saveSet_showsSaveActionSheetWhenPoemsSelected() throws {
    // given - 歌が選択されている状態
    viewModel.input.selectPoem.send(1)
    viewModel.input.selectPoem.send(15)
    viewModel.input.selectPoem.send(42)
    XCTAssertEqual(viewModel.output.selectedCount, 3)
    XCTAssertFalse(viewModel.binding.showSaveActionSheet)
    XCTAssertFalse(viewModel.binding.showEmptySetAlert)

    // when - 保存を試行
    viewModel.input.saveSet.send()

    // then - 保存アクションシートが表示される準備ができている
    XCTAssertTrue(viewModel.binding.showSaveActionSheet, "歌選択済み時はshowSaveActionSheetがtrueになるべき")
    XCTAssertFalse(viewModel.binding.showEmptySetAlert, "歌選択済み時は空札セットアラートは表示されない")
  }

  // MARK: - New Fuda Set Name Tests

  func test_saveNewFudaSet_showsAlertWhenNameIsEmpty() throws {
    // given - 歌を選択済み状態で、空の札セット名を設定
    viewModel.input.selectPoem.send(1)
    viewModel.input.selectPoem.send(25)
    XCTAssertEqual(viewModel.output.selectedCount, 2)

    let initialFudaSetsCount = testSettings.savedFudaSets.count
    XCTAssertFalse(viewModel.binding.showNoNameGivenAlert)
    XCTAssertFalse(viewModel.binding.showSuccessAlert)

    // when - 空文字列で札セット名を保存試行
    viewModel.binding.newSetName = ""
    viewModel.saveNewFudaSet()

    // then - 専用の警告アラートが表示される準備ができている
    XCTAssertTrue(viewModel.binding.showNoNameGivenAlert, "空の札セット名時はshowNoNameGivenAlertがtrueになるべき")
    XCTAssertFalse(viewModel.binding.showSuccessAlert, "空の札セット名時は成功アラートは表示されない")
    XCTAssertEqual(testSettings.savedFudaSets.count, initialFudaSetsCount, "札セットは追加されない")
  }

  func test_saveNewFudaSet_showsAlertWhenNameIsWhitespaceOnly() throws {
    // given - 歌を選択済み状態で、空白のみの札セット名を設定
    viewModel.input.selectPoem.send(10)
    XCTAssertEqual(viewModel.output.selectedCount, 1)

    let initialFudaSetsCount = testSettings.savedFudaSets.count
    XCTAssertFalse(viewModel.binding.showNoNameGivenAlert)
    XCTAssertFalse(viewModel.binding.showSuccessAlert)

    // when - 空白のみで札セット名を保存試行
    viewModel.binding.newSetName = "   \t\n  "
    viewModel.saveNewFudaSet()

    // then - 専用の警告アラートが表示される準備ができている
    XCTAssertTrue(viewModel.binding.showNoNameGivenAlert, "空白のみの札セット名時はshowNoNameGivenAlertがtrueになるべき")
    XCTAssertFalse(viewModel.binding.showSuccessAlert, "空白のみの札セット名時は成功アラートは表示されない")
    XCTAssertEqual(testSettings.savedFudaSets.count, initialFudaSetsCount, "札セットは追加されない")
  }

  func test_saveNewFudaSet_succedsWithValidName() throws {
    // given - 歌を選択済み状態で、有効な札セット名を設定
    viewModel.input.selectPoem.send(5)
    viewModel.input.selectPoem.send(50)
    viewModel.input.selectPoem.send(95)
    XCTAssertEqual(viewModel.output.selectedCount, 3)

    let initialFudaSetsCount = testSettings.savedFudaSets.count
    XCTAssertFalse(viewModel.binding.showNoNameGivenAlert)
    XCTAssertFalse(viewModel.binding.showSuccessAlert)

    let validName = "テスト札セット"

    // when - 有効な名前で札セット名を保存
    viewModel.binding.newSetName = validName
    viewModel.saveNewFudaSet()

    // then - 成功処理が実行される
    XCTAssertFalse(viewModel.binding.showNoNameGivenAlert, "有効な札セット名時は警告アラートは表示されない")
    XCTAssertTrue(viewModel.binding.showSuccessAlert, "有効な札セット名時は成功アラートが表示される")
    XCTAssertEqual(testSettings.savedFudaSets.count, initialFudaSetsCount + 1, "札セットが追加される")
    XCTAssertEqual(testSettings.savedFudaSets.last?.name, validName, "札セット名が正しく設定される")
    XCTAssertEqual(viewModel.binding.newSetName, "", "保存後、新しい札セット名はクリアされる")
    XCTAssertEqual(viewModel.binding.successAlertTitle, "保存完了", "成功アラートのタイトルが設定される")
    XCTAssertEqual(viewModel.output.successMessage, "新しい札セット「\(validName)」を保存しました。", "成功メッセージが設定される")
  }

  func test_saveNewFudaSet_trimsWhitespaceFromValidName() throws {
    // given - 歌を選択済み状態で、前後に空白がある有効な札セット名を設定
    viewModel.input.selectPoem.send(33)
    XCTAssertEqual(viewModel.output.selectedCount, 1)

    let initialFudaSetsCount = testSettings.savedFudaSets.count
    let nameWithWhitespace = "  春の札セット  \n"
    let expectedTrimmedName = "春の札セット"

    // when - 前後に空白がある名前で札セット名を保存
    viewModel.binding.newSetName = nameWithWhitespace
    viewModel.saveNewFudaSet()

    // then - 空白が削除された名前で保存される
    XCTAssertTrue(viewModel.binding.showSuccessAlert, "空白を含む有効な札セット名時は成功アラートが表示される")
    XCTAssertEqual(testSettings.savedFudaSets.count, initialFudaSetsCount + 1, "札セットが追加される")
    XCTAssertEqual(testSettings.savedFudaSets.last?.name, expectedTrimmedName, "札セット名から空白が削除されて設定される")
    XCTAssertEqual(viewModel.output.successMessage, "新しい札セット「\(expectedTrimmedName)」を保存しました。", "成功メッセージも削除された名前で表示される")
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
    let expectation = XCTestExpectation(description: "Combine publishers work correctly")
    var receivedSelectedCounts: [Int] = []

    // Outputの変更を監視
    viewModel.output.$selectedCount
      .sink { count in
        receivedSelectedCounts.append(count)
        if receivedSelectedCounts.count >= 4 {  // 初期値 + 3回の変更
          expectation.fulfill()
        }
      }
      .store(in: &cancellables)

    // when - 複数の選択操作
    DispatchQueue.main.async {
      self.viewModel.input.selectPoem.send(1)   // +1
      self.viewModel.input.selectPoem.send(2)   // +1
      self.viewModel.input.selectPoem.send(1)   // -1 (選択解除)
    }

    // then
    wait(for: [expectation], timeout: 1.0)
    XCTAssertEqual(receivedSelectedCounts.count, 4)
    // 初期値、+1、+1、-1の順序で変更されることを確認
    XCTAssertEqual(receivedSelectedCounts[1], receivedSelectedCounts[0] + 1)
    XCTAssertEqual(receivedSelectedCounts[2], receivedSelectedCounts[1] + 1)
    XCTAssertEqual(receivedSelectedCounts[3], receivedSelectedCounts[2] - 1)
  }
}
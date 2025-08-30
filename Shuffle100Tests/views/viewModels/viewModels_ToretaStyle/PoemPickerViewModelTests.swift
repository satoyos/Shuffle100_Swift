//
//  PoemPickerViewModelTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2025/08/17.
//  Copyright © 2025 里 佳史. All rights reserved.
//

import XCTest
import Combine
@testable import Shuffle100

class PoemPickerViewModelTests: XCTestCase {
  
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
  
  // MARK: - Initialization Tests
  
  func test_initViewModel() throws {
    // then
    XCTAssertNotNil(viewModel)
    XCTAssertNotNil(viewModel.input)
    XCTAssertNotNil(viewModel.binding)
    XCTAssertNotNil(viewModel.output)
    XCTAssertEqual(viewModel.output.filteredPoems.count, 100)
    XCTAssertEqual(viewModel.output.filteredPoems, PoemSupplier.originalPoems)
    XCTAssertEqual(viewModel.output.selectedCount, testSettings.state100.selectedNum)
    XCTAssertEqual(viewModel.binding.searchText, "")
    XCTAssertFalse(viewModel.output.isSearching)
  }
  
  func test_initialSelectedCount() throws {
    // given - 初期状態で数首選択済みのSettings
    var initialState = SelectedState100.allUnselected
    initialState = initialState.reverseInNumber(1)
    initialState = initialState.reverseInNumber(5)
    initialState = initialState.reverseInNumber(10)
    testSettings.state100 = initialState
    
    // when
    let viewModelWithSelection = PoemPickerView.ViewModel(settings: testSettings)
    
    // then
    XCTAssertEqual(viewModelWithSelection.output.selectedCount, 3)
  }
  
  // MARK: - Poem Selection Tests
  
  func test_selectPoem_newSelection() throws {
    // given
    let initialSelectedCount = viewModel.output.selectedCount
    let poemNumber = 42
    XCTAssertFalse(viewModel.isPoemSelected(poemNumber))
    
    // when
    viewModel.input.selectPoem.send(poemNumber)
    
    // then
    XCTAssertTrue(viewModel.isPoemSelected(poemNumber))
    XCTAssertEqual(viewModel.output.selectedCount, initialSelectedCount + 1)
  }
  
  func test_selectPoem_deselectExisting() throws {
    // given - 予め歌を選択しておく
    let poemNumber = 25
    viewModel.input.selectPoem.send(poemNumber)
    XCTAssertTrue(viewModel.isPoemSelected(poemNumber))
    let selectedCountAfterSelection = viewModel.output.selectedCount
    
    // when - 同じ歌を再度選択（選択解除）
    viewModel.input.selectPoem.send(poemNumber)
    
    // then
    XCTAssertFalse(viewModel.isPoemSelected(poemNumber))
    XCTAssertEqual(viewModel.output.selectedCount, selectedCountAfterSelection - 1)
  }
  
  func test_selectPoem_multipleSelections() throws {
    // given
    let poems = [1, 15, 33, 67, 89]
    let initialCount = viewModel.output.selectedCount
    
    // when
    for poem in poems {
      viewModel.input.selectPoem.send(poem)
    }
    
    // then
    for poem in poems {
      XCTAssertTrue(viewModel.isPoemSelected(poem))
    }
    XCTAssertEqual(viewModel.output.selectedCount, initialCount + poems.count)
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
  
  // MARK: - Select All / Cancel All Tests
  
  func test_selectAll() throws {
    // given - 初期状態で一部選択解除しておく
    viewModel.input.cancelAll.send()
    XCTAssertEqual(viewModel.output.selectedCount, 0)
    
    // when
    viewModel.input.selectAll.send()
    
    // then
    XCTAssertEqual(viewModel.output.selectedCount, 100)
    for i in 1...100 {
      XCTAssertTrue(viewModel.isPoemSelected(i))
    }
  }
  
  func test_cancelAll() throws {
    // given - 予め全選択しておく
    viewModel.input.selectAll.send()
    XCTAssertEqual(viewModel.output.selectedCount, 100)
    
    // when
    viewModel.input.cancelAll.send()
    
    // then
    XCTAssertEqual(viewModel.output.selectedCount, 0)
    for i in 1...100 {
      XCTAssertFalse(viewModel.isPoemSelected(i))
    }
  }
  
  func test_selectAll_thenCancelAll() throws {
    // when - 全選択→全取消の流れ
    viewModel.input.selectAll.send()
    XCTAssertEqual(viewModel.output.selectedCount, 100)
    
    viewModel.input.cancelAll.send()
    
    // then
    XCTAssertEqual(viewModel.output.selectedCount, 0)
  }
  
  // MARK: - isPoemSelected Tests
  
  func test_isPoemSelected_validNumbers() throws {
    // given
    let selectedPoems = [1, 50, 100]
    let unselectedPoems = [2, 51, 99]
    
    // when
    for poem in selectedPoems {
      viewModel.input.selectPoem.send(poem)
    }
    
    // then
    for poem in selectedPoems {
      XCTAssertTrue(viewModel.isPoemSelected(poem))
    }
    for poem in unselectedPoems {
      XCTAssertFalse(viewModel.isPoemSelected(poem))
    }
  }
  
  func test_isPoemSelected_invalidNumbers() throws {
    // when/then - 無効な番号は常にfalse
    XCTAssertFalse(viewModel.isPoemSelected(0))
    XCTAssertFalse(viewModel.isPoemSelected(101))
    XCTAssertFalse(viewModel.isPoemSelected(-1))
    XCTAssertFalse(viewModel.isPoemSelected(999))
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
}

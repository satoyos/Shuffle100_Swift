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

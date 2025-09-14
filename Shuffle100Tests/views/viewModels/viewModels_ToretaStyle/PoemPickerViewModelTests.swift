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
}
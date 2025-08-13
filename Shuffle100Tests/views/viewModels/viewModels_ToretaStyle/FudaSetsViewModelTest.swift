//
//  FudaSetsViewModelTest.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2025/01/12.
//  Copyright © 2025 里 佳史. All rights reserved.
//

import XCTest
import Combine
@testable import Shuffle100

class FudaSetsViewModelTest: XCTestCase {
  
  var viewModel: FudaSetsView.ViewModel!
  var cancellables: Set<AnyCancellable> = []
  
  override func setUpWithError() throws {
    let testFudaSets = [
      SavedFudaSet(name: "テストセット1", state100: createTestState(selectedCount: 25)),
      SavedFudaSet(name: "テストセット2", state100: createTestState(selectedCount: 50))
    ]
    viewModel = FudaSetsView.ViewModel(savedFudaSets: testFudaSets)
  }
  
  override func tearDownWithError() throws {
    viewModel = nil
    cancellables.removeAll()
  }
  
  // MARK: - Initialization Tests
  
  func test_initViewModel() throws {
    // then
    XCTAssertNotNil(viewModel)
    XCTAssertEqual(viewModel.output.savedFudaSets.count, 2)
    XCTAssertEqual(viewModel.output.savedFudaSets[0].name, "テストセット1")
    XCTAssertEqual(viewModel.output.savedFudaSets[1].name, "テストセット2")
    XCTAssertEqual(viewModel.output.savedFudaSets[0].state100.selectedNum, 25)
    XCTAssertEqual(viewModel.output.savedFudaSets[1].state100.selectedNum, 50)
  }
  
  func test_emptyViewModel() throws {
    // given
    let emptyViewModel = FudaSetsView.ViewModel(savedFudaSets: [])
    
    // then
    XCTAssertEqual(emptyViewModel.output.savedFudaSets.count, 0)
    XCTAssertTrue(emptyViewModel.output.savedFudaSets.isEmpty)
  }
  
  // MARK: - Select FudaSet Tests
  
  func test_selectFudaSet_validIndex() throws {
    // given
    let initialState = viewModel.output.selectedState100
    XCTAssertNil(viewModel.output.selectedIndex)
    
    // when
    viewModel.input.selectFudaSet.send(0)
    
    // then
    XCTAssertEqual(viewModel.output.selectedState100.selectedNum, 25)
    XCTAssertNotEqual(viewModel.output.selectedState100, initialState)
    XCTAssertEqual(viewModel.output.selectedIndex, 0)
  }
  
  func test_selectFudaSet_invalidIndex() throws {
    // given
    let initialState = viewModel.output.selectedState100
    let initialSelectedIndex = viewModel.output.selectedIndex
    
    // when
    viewModel.input.selectFudaSet.send(10) // Invalid index
    
    // then
    XCTAssertEqual(viewModel.output.selectedState100, initialState) // 変更されない
    XCTAssertEqual(viewModel.output.selectedIndex, initialSelectedIndex) // 変更されない
  }
  
  func test_selectFudaSet_emptyList() throws {
    // given
    let emptyViewModel = FudaSetsView.ViewModel(savedFudaSets: [])
    let initialState = emptyViewModel.output.selectedState100
    let initialSelectedIndex = emptyViewModel.output.selectedIndex
    
    // when
    emptyViewModel.input.selectFudaSet.send(0)
    
    // then
    XCTAssertEqual(emptyViewModel.output.selectedState100, initialState)
    XCTAssertEqual(emptyViewModel.output.selectedIndex, initialSelectedIndex)
  }
  
  // MARK: - Delete FudaSet Tests
  
  func test_deleteFudaSet_singleItem() throws {
    // given
    let singleItemViewModel = FudaSetsView.ViewModel(
      savedFudaSets: [SavedFudaSet(name: "削除対象", state100: createTestState(selectedCount: 15))]
    )
    XCTAssertEqual(singleItemViewModel.output.savedFudaSets.count, 1)
    
    // when
    let indexSet = IndexSet(integer: 0)
    singleItemViewModel.input.deleteFudaSet.send(indexSet)
    
    // then
    XCTAssertEqual(singleItemViewModel.output.savedFudaSets.count, 0)
  }
  
  func test_deleteFudaSet_multipleItems() throws {
    // given
    XCTAssertEqual(viewModel.output.savedFudaSets.count, 2)
    XCTAssertEqual(viewModel.output.savedFudaSets[0].name, "テストセット1")
    XCTAssertEqual(viewModel.output.savedFudaSets[1].name, "テストセット2")
    
    // when - Delete first item (index 0)
    let indexSet = IndexSet(integer: 0)
    viewModel.input.deleteFudaSet.send(indexSet)
    
    // then
    XCTAssertEqual(viewModel.output.savedFudaSets.count, 1)
    XCTAssertEqual(viewModel.output.savedFudaSets[0].name, "テストセット2") // テストセット1が削除され、テストセット2が残る
  }
  
  func test_deleteFudaSet_multipleIndexes() throws {
    // given
    let fudaSets = [
      SavedFudaSet(name: "セット1", state100: createTestState(selectedCount: 10)),
      SavedFudaSet(name: "セット2", state100: createTestState(selectedCount: 20)),
      SavedFudaSet(name: "セット3", state100: createTestState(selectedCount: 30)),
      SavedFudaSet(name: "セット4", state100: createTestState(selectedCount: 40))
    ]
    let multiItemViewModel = FudaSetsView.ViewModel(savedFudaSets: fudaSets)
    
    // when - Delete first and third items (indexes 0 and 2)
    var indexSet = IndexSet()
    indexSet.insert(0)
    indexSet.insert(2)
    multiItemViewModel.input.deleteFudaSet.send(indexSet)
    
    // then
    XCTAssertEqual(multiItemViewModel.output.savedFudaSets.count, 2)
    XCTAssertEqual(multiItemViewModel.output.savedFudaSets[0].name, "セット2")
    XCTAssertEqual(multiItemViewModel.output.savedFudaSets[1].name, "セット4")
  }
  
  // MARK: - Integration Tests
  
  func test_selectAndDelete_integration() throws {
    // given
    let integrationViewModel = FudaSetsView.ViewModel(savedFudaSets: [
      SavedFudaSet(name: "統合テスト1", state100: createTestState(selectedCount: 35)),
      SavedFudaSet(name: "統合テスト2", state100: createTestState(selectedCount: 65))
    ])
    
    // when - Select first, then delete it
    integrationViewModel.input.selectFudaSet.send(0)
    XCTAssertEqual(integrationViewModel.output.selectedState100.selectedNum, 35)
    
    let indexSet = IndexSet(integer: 0)
    integrationViewModel.input.deleteFudaSet.send(indexSet)
    
    // then
    XCTAssertEqual(integrationViewModel.output.savedFudaSets.count, 1)
    XCTAssertEqual(integrationViewModel.output.savedFudaSets[0].name, "統合テスト2")
  }
  
  func test_combineOperations() throws {
    // given
    XCTAssertEqual(viewModel.output.savedFudaSets.count, 2)
    
    // when - Select second item, then delete first item
    viewModel.input.selectFudaSet.send(1)
    XCTAssertEqual(viewModel.output.selectedState100.selectedNum, 50)
    XCTAssertEqual(viewModel.output.selectedIndex, 1)
    
    let indexSet = IndexSet(integer: 0)
    viewModel.input.deleteFudaSet.send(indexSet)
    
    // then
    XCTAssertEqual(viewModel.output.savedFudaSets.count, 1)
    XCTAssertEqual(viewModel.output.savedFudaSets[0].name, "テストセット2")
    // 選択状態は削除操作で変更されない（インデックスは調整される）
    XCTAssertEqual(viewModel.output.selectedState100.selectedNum, 50)
    XCTAssertEqual(viewModel.output.selectedIndex, 0) // インデックスが1から0に調整される
  }
  
  // MARK: - Selection Index Tests
  
  func test_deleteSelectedItem() throws {
    // given - Select first item
    viewModel.input.selectFudaSet.send(0)
    XCTAssertEqual(viewModel.output.selectedIndex, 0)
    
    // when - Delete selected item
    let indexSet = IndexSet(integer: 0)
    viewModel.input.deleteFudaSet.send(indexSet)
    
    // then - Selection should be cleared
    XCTAssertNil(viewModel.output.selectedIndex)
    XCTAssertEqual(viewModel.output.savedFudaSets.count, 1)
  }
  
  func test_multipleSelection() throws {
    // given
    XCTAssertNil(viewModel.output.selectedIndex)
    
    // when - Select first item
    viewModel.input.selectFudaSet.send(0)
    XCTAssertEqual(viewModel.output.selectedIndex, 0)
    
    // when - Select second item (should override)
    viewModel.input.selectFudaSet.send(1)
    
    // then
    XCTAssertEqual(viewModel.output.selectedIndex, 1)
    XCTAssertEqual(viewModel.output.selectedState100.selectedNum, 50)
  }
  
  // MARK: - Helper Methods
  
  private func createTestState(selectedCount: Int) -> SelectedState100 {
    var boolArray = Bool100.allUnselected
    for i in 0..<min(selectedCount, 100) {
      boolArray[i] = true
    }
    return SelectedState100(bool100: boolArray)
  }
}
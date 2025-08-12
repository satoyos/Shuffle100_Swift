//
//  FudaSetsViewModelTest.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2025/01/12.
//  Copyright © 2025 里 佳史. All rights reserved.
//

import XCTest
@testable import Shuffle100

class FudaSetsViewModelTest: XCTestCase {
  
  var viewModel: FudaSetsView.ViewModel!
  var settings: Settings!
  var saveActionCalled: Bool!
  
  override func setUpWithError() throws {
    settings = Settings()
    saveActionCalled = false
    viewModel = FudaSetsView.ViewModel(
      settings: settings,
      saveAction: { [weak self] in
        self?.saveActionCalled = true
      }
    )
  }
  
  override func tearDownWithError() throws {
    viewModel = nil
    settings = nil
    saveActionCalled = nil
  }
  
  // MARK: - Computed Property Tests
  
  func test_savedFudaSets_emptyInitially() throws {
    // then
    XCTAssertEqual(viewModel.savedFudaSets.count, 0)
    XCTAssertTrue(viewModel.savedFudaSets.isEmpty)
  }
  
  func test_savedFudaSets_reflectsSettingsChanges() throws {
    // given
    let fudaSet1 = SavedFudaSet(name: "テストセット1", state100: createTestState(selectedCount: 25))
    let fudaSet2 = SavedFudaSet(name: "テストセット2", state100: createTestState(selectedCount: 50))
    
    // when
    settings.savedFudaSets = [fudaSet1, fudaSet2]
    
    // then - computed propertyが即座に反映される
    XCTAssertEqual(viewModel.savedFudaSets.count, 2)
    XCTAssertEqual(viewModel.savedFudaSets[0].name, "テストセット1")
    XCTAssertEqual(viewModel.savedFudaSets[1].name, "テストセット2")
    XCTAssertEqual(viewModel.savedFudaSets[0].state100.selectedNum, 25)
    XCTAssertEqual(viewModel.savedFudaSets[1].state100.selectedNum, 50)
  }
  
  func test_savedFudaSets_dynamicUpdates() throws {
    // given
    let initialFudaSet = SavedFudaSet(name: "初期セット", state100: createTestState(selectedCount: 10))
    settings.savedFudaSets = [initialFudaSet]
    XCTAssertEqual(viewModel.savedFudaSets.count, 1)
    
    // when - Settingsに直接追加
    let newFudaSet = SavedFudaSet(name: "新セット", state100: createTestState(selectedCount: 30))
    settings.savedFudaSets.append(newFudaSet)
    
    // then - computed propertyが自動更新
    XCTAssertEqual(viewModel.savedFudaSets.count, 2)
    XCTAssertEqual(viewModel.savedFudaSets[1].name, "新セット")
    XCTAssertEqual(viewModel.savedFudaSets[1].state100.selectedNum, 30)
  }
  
  // MARK: - Select FudaSet Tests
  
  func test_selectFudaSet_validIndex() throws {
    // given
    let testState = createTestState(selectedCount: 40)
    let fudaSet = SavedFudaSet(name: "40首セット", state100: testState)
    settings.savedFudaSets = [fudaSet]
    
    // when
    viewModel.selectFudaSet(at: 0)
    
    // then
    XCTAssertEqual(settings.state100, testState)
    XCTAssertTrue(saveActionCalled)
  }
  
  func test_selectFudaSet_invalidIndex() throws {
    // given
    let fudaSet = SavedFudaSet(name: "テストセット", state100: createTestState(selectedCount: 20))
    settings.savedFudaSets = [fudaSet]
    let originalState = settings.state100
    
    // when
    viewModel.selectFudaSet(at: 1) // Invalid index
    
    // then
    XCTAssertEqual(settings.state100, originalState) // 変更されない
    XCTAssertFalse(saveActionCalled)
  }
  
  func test_selectFudaSet_emptyList() throws {
    // given
    settings.savedFudaSets = []
    let originalState = settings.state100
    
    // when
    viewModel.selectFudaSet(at: 0)
    
    // then
    XCTAssertEqual(settings.state100, originalState)
    XCTAssertFalse(saveActionCalled)
  }
  
  // MARK: - Delete FudaSet Tests
  
  func test_deleteFudaSet_singleItem() throws {
    // given
    let fudaSet = SavedFudaSet(name: "削除対象", state100: createTestState(selectedCount: 15))
    settings.savedFudaSets = [fudaSet]
    XCTAssertEqual(viewModel.savedFudaSets.count, 1)
    
    // when
    let indexSet = IndexSet(integer: 0)
    viewModel.deleteFudaSet(at: indexSet)
    
    // then
    XCTAssertEqual(viewModel.savedFudaSets.count, 0) // computed propertyが即座に反映
    XCTAssertEqual(settings.savedFudaSets.count, 0)
    XCTAssertTrue(saveActionCalled)
  }
  
  func test_deleteFudaSet_multipleItems() throws {
    // given
    let fudaSet1 = SavedFudaSet(name: "セット1", state100: createTestState(selectedCount: 10))
    let fudaSet2 = SavedFudaSet(name: "セット2", state100: createTestState(selectedCount: 20))
    let fudaSet3 = SavedFudaSet(name: "セット3", state100: createTestState(selectedCount: 30))
    settings.savedFudaSets = [fudaSet1, fudaSet2, fudaSet3]
    
    // when - Delete middle item (index 1)
    let indexSet = IndexSet(integer: 1)
    viewModel.deleteFudaSet(at: indexSet)
    
    // then
    XCTAssertEqual(viewModel.savedFudaSets.count, 2)
    XCTAssertEqual(viewModel.savedFudaSets[0].name, "セット1")
    XCTAssertEqual(viewModel.savedFudaSets[1].name, "セット3") // セット2が削除され、セット3が繰り上がり
    XCTAssertTrue(saveActionCalled)
  }
  
  func test_deleteFudaSet_multipleIndexes() throws {
    // given
    let fudaSets = [
      SavedFudaSet(name: "セット1", state100: createTestState(selectedCount: 10)),
      SavedFudaSet(name: "セット2", state100: createTestState(selectedCount: 20)),
      SavedFudaSet(name: "セット3", state100: createTestState(selectedCount: 30)),
      SavedFudaSet(name: "セット4", state100: createTestState(selectedCount: 40))
    ]
    settings.savedFudaSets = fudaSets
    
    // when - Delete first and third items (indexes 0 and 2)
    var indexSet = IndexSet()
    indexSet.insert(0)
    indexSet.insert(2)
    viewModel.deleteFudaSet(at: indexSet)
    
    // then
    XCTAssertEqual(viewModel.savedFudaSets.count, 2)
    XCTAssertEqual(viewModel.savedFudaSets[0].name, "セット2")
    XCTAssertEqual(viewModel.savedFudaSets[1].name, "セット4")
    XCTAssertTrue(saveActionCalled)
  }
  
  // MARK: - Integration Tests
  
  func test_selectAndDelete_integration() throws {
    // given
    let fudaSet1 = SavedFudaSet(name: "統合テスト1", state100: createTestState(selectedCount: 35))
    let fudaSet2 = SavedFudaSet(name: "統合テスト2", state100: createTestState(selectedCount: 65))
    settings.savedFudaSets = [fudaSet1, fudaSet2]
    
    // when - Select first, then delete it
    viewModel.selectFudaSet(at: 0)
    XCTAssertEqual(settings.state100.selectedNum, 35)
    XCTAssertTrue(saveActionCalled)
    
    saveActionCalled = false // Reset for next test
    
    let indexSet = IndexSet(integer: 0)
    viewModel.deleteFudaSet(at: indexSet)
    
    // then
    XCTAssertEqual(viewModel.savedFudaSets.count, 1)
    XCTAssertEqual(viewModel.savedFudaSets[0].name, "統合テスト2")
    XCTAssertTrue(saveActionCalled)
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
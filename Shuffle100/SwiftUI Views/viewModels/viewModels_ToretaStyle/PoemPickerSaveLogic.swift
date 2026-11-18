//
//  PoemPickerSaveLogic.swift
//  Shuffle100
//
//  Created by Claude Code on 2025/09/05.
//  Copyright © 2025 里 佳史. All rights reserved.
//

import Foundation

// MARK: - Save Logic Protocol
protocol PoemPickerSaveHandling {
  static func handleSaveRequest(selectedCount: Int) -> PoemPickerSaveAction
  func saveNewFudaSet(name: String, settings: Settings) -> PoemPickerSaveResult
  func overwriteExistingFudaSet(at index: Int, availableOverwriteSets: [SavedFudaSet], settings: Settings) -> PoemPickerSaveResult
}

// MARK: - Save Action Types
enum PoemPickerSaveAction: Equatable {
  case showActionSheet
  case showEmptySetAlert
}

struct PoemPickerSaveResult {
  let successMessage: String
  let alertTitle: String
}

// MARK: - Save Logic Implementation
extension PoemPickerView.ViewModel {
  
  final class SaveLogic: PoemPickerSaveHandling {
    static func handleSaveRequest(selectedCount: Int) -> PoemPickerSaveAction {
      if selectedCount > 0 {
        return .showActionSheet
      } else {
        return .showEmptySetAlert
      }
    }
    
    func saveNewFudaSet(name: String, settings: Settings) -> PoemPickerSaveResult {
      let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
      
      guard !trimmedName.isEmpty else {
        return PoemPickerSaveResult(
          successMessage: "",
          alertTitle: ""
        )
      }
      
      let newFudaSet = SavedFudaSet(name: trimmedName, state100: settings.state100)
      settings.savedFudaSets.append(newFudaSet)
      
      return PoemPickerSaveResult(
        successMessage: "新しい札セット「\(trimmedName)」を保存しました。",
        alertTitle: "保存完了"
      )
    }
    
    func overwriteExistingFudaSet(at index: Int, availableOverwriteSets: [SavedFudaSet], settings: Settings) -> PoemPickerSaveResult {
      let selectedSet = availableOverwriteSets[index]
      let updatedSet = SavedFudaSet(name: selectedSet.name, state100: settings.state100)
      settings.savedFudaSets[index] = updatedSet
      
      return PoemPickerSaveResult(
        successMessage: "前に作った札セット「\(selectedSet.name)」を上書き保存しました。",
        alertTitle: "上書き完了"
      )
    }
  }
}

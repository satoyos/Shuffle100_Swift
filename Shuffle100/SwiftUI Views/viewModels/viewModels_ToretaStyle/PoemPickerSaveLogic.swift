//
//  PoemPickerSaveLogic.swift
//  Shuffle100
//
//  Created by Claude Code on 2025/09/05.
//  Copyright © 2025 里 佳史. All rights reserved.
//

import Foundation
import Combine

// MARK: - Save Logic Protocol
protocol PoemPickerSaveHandling {
  static func handleSaveRequest(selectedCount: Int) -> PoemPickerSaveAction
  func saveNewFudaSet(name: String, settings: Settings) -> PoemPickerSaveResult
  func overwriteExistingFudaSet(at index: Int, availableOverwriteSets: [SavedFudaSet], settings: Settings) -> PoemPickerSaveResult
  func prepareNewSetCreation() -> Void
  func prepareOverwriteSelection() -> Void
}

// MARK: - Save Action Types
enum PoemPickerSaveAction {
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
    weak var binding: PoemPickerView.ViewModel.Binding?
    
    init(binding: PoemPickerView.ViewModel.Binding) {
      self.binding = binding
    }
    
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
        binding?.showNoNameGivenAlert = true
        return PoemPickerSaveResult(
          successMessage: "",
          alertTitle: ""
        )
      }
      
      let newFudaSet = SavedFudaSet(name: trimmedName, state100: settings.state100)
      settings.savedFudaSets.append(newFudaSet)
      
      binding?.newSetName = ""
      
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
    
    func prepareNewSetCreation() {
      binding?.newSetName = ""
      binding?.showNewSetNameAlert = true
    }
    
    func prepareOverwriteSelection() {
      binding?.selectedOverwriteIndex = 0
      binding?.showOverwritePickerAlert = true
    }
  }
}
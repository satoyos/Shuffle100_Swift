//
//  PoemPickerView.ViewModel.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/08/17.
//  Copyright © 2025 里 佳史. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

extension PoemPickerView {
  final class ViewModel: ViewModelObject {
    
    final class Input: InputObject {
      let selectPoem = PassthroughSubject<Int, Never>()
      let selectAll = PassthroughSubject<Void, Never>()
      let cancelAll = PassthroughSubject<Void, Never>()
      let showDetail = PassthroughSubject<Int, Never>()
      let saveSet = PassthroughSubject<Void, Never>()
      let selectByGroup = PassthroughSubject<Void, Never>()
    }
    
    final class Binding: BindingObject {
      @Published var searchText: String = ""
      @Published var showActionSheet: Bool = false
      @Published var showSaveActionSheet: Bool = false
      @Published var showNewSetNameAlert: Bool = false
      @Published var showOverwritePickerAlert: Bool = false
      @Published var showSuccessAlert: Bool = false
      @Published var showEmptySetAlert: Bool = false
      @Published var showNoNameGivenAlert: Bool = false
      @Published var newSetName: String = ""
      @Published var selectedOverwriteIndex: Int = 0
      @Published var successAlertTitle: String = ""
    }
    
    final class Output: OutputObject {
      @Published var filteredPoems: [Poem] = []
      @Published var selectedCount: Int = 0
      @Published var isSearching: Bool = false
      @Published var successMessage: String = ""
      @Published var availableOverwriteSets: [SavedFudaSet] = []
    }
    
    let input: Input
    @BindableObject var binding: Binding
    let output: Output
    var cancellables: Set<AnyCancellable> = []
    
    private let settings: Settings
    
    init(settings: Settings) {
      let input = Input()
      let binding = Binding()
      let output = Output()
      
      self.settings = settings
      
      // 初期表示：全歌をフィルター済みリストにセット
      output.filteredPoems = PoemSupplier.originalPoems
      output.selectedCount = settings.state100.selectedNum
      
      // 歌選択の処理
      input.selectPoem
        .sink { poemNumber in
          let newState100 = settings.state100.reverseInNumber(poemNumber)
          settings.state100 = newState100
          output.selectedCount = newState100.selectedNum
        }
        .store(in: &cancellables)
      
      // 検索テキストの処理
      binding.$searchText
        .removeDuplicates()
        .sink { searchText in
          output.isSearching = !searchText.isEmpty
          
          if searchText.isEmpty {
            output.filteredPoems = PoemSupplier.originalPoems
          } else {
            output.filteredPoems = PoemSupplier.originalPoems.filter { poem in
              poem.searchText.lowercased().contains(searchText.lowercased())
            }
          }
        }
        .store(in: &cancellables)
      
      // 全選択の処理
      input.selectAll
        .sink { _ in
          let newState100 = settings.state100.selectAll()
          settings.state100 = newState100
          output.selectedCount = newState100.selectedNum
        }
        .store(in: &cancellables)
      
      // 全取消の処理
      input.cancelAll
        .sink { _ in
          let newState100 = settings.state100.cancelAll()
          settings.state100 = newState100
          output.selectedCount = newState100.selectedNum
        }
        .store(in: &cancellables)
      
      // 保存ボタンタップの処理
      input.saveSet
        .sink { _ in
          if settings.state100.selectedNum > 0 {
            binding.showSaveActionSheet = true
            output.availableOverwriteSets = settings.savedFudaSets
          } else {
            binding.showEmptySetAlert = true
          }
        }
        .store(in: &cancellables)
      
      self.input = input
      self.binding = binding
      self.output = output
    }
    
    func isPoemSelected(_ poemNumber: Int) -> Bool {
      do {
        return try settings.state100.ofNumber(poemNumber)
      } catch {
        return false
      }
    }
    
    func refreshFromSettings() {
      output.selectedCount = settings.state100.selectedNum
    }
    
    // MARK: - Save Set Logic
    func saveNewFudaSet() {
      let trimmedName = binding.newSetName.trimmingCharacters(in: .whitespacesAndNewlines)
      
      guard !trimmedName.isEmpty else {
        // 名前が空の場合、専用の警告アラートを表示
        binding.showNoNameGivenAlert = true
        return
      }
      
      let newFudaSet = SavedFudaSet(name: trimmedName, state100: settings.state100)
      settings.savedFudaSets.append(newFudaSet)
      
      output.successMessage = "新しい札セット「\(trimmedName)」を保存しました。"
      binding.successAlertTitle = "保存完了"
      binding.showSuccessAlert = true
      binding.newSetName = ""
    }
    
    func overwriteExistingFudaSet() {
      let selectedSet = output.availableOverwriteSets[binding.selectedOverwriteIndex]
      let updatedSet = SavedFudaSet(name: selectedSet.name, state100: settings.state100)
      settings.savedFudaSets[binding.selectedOverwriteIndex] = updatedSet
      
      output.successMessage = "前に作った札セット「\(selectedSet.name)」を上書き保存しました。"
      binding.successAlertTitle = "上書き完了"
      binding.showSuccessAlert = true
    }
    
    func prepareNewSetCreation() {
      binding.newSetName = ""
      binding.showNewSetNameAlert = true
    }
    
    func prepareOverwriteSelection() {
      binding.selectedOverwriteIndex = 0
      binding.showOverwritePickerAlert = true
    }
  }
}
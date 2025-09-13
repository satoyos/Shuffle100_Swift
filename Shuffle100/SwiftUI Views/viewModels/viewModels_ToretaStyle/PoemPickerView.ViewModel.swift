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
    private let saveLogic: PoemPickerView.ViewModel.SaveLogic
    private let selectionLogic: PoemPickerView.ViewModel.SelectionLogic
    
    init(settings: Settings) {
      let input = Input()
      let binding = Binding()
      let output = Output()
      
      self.settings = settings
      self.saveLogic = PoemPickerView.ViewModel.SaveLogic(binding: binding)
      self.selectionLogic = PoemPickerView.ViewModel.SelectionLogic()

      // 初期表示：全歌をフィルター済みリストにセット
      output.filteredPoems = PoemSupplier.originalPoems
      output.selectedCount = settings.state100.selectedNum

      // Selection Logic のCombine設定
      PoemPickerView.ViewModel.SelectionCombineSetup.setupSelectionPublishers(
        input: input,
        binding: binding,
        output: output,
        settings: settings,
        selectionLogic: selectionLogic,
        cancellables: &cancellables
      )

      // 保存ボタンタップの処理
      input.saveSet
        .sink { _ in
          let saveAction = PoemPickerView.ViewModel.SaveLogic.handleSaveRequest(
            selectedCount: settings.state100.selectedNum
          )

          switch saveAction {
          case .showActionSheet:
            binding.showSaveActionSheet = true
            output.availableOverwriteSets = settings.savedFudaSets
          case .showEmptySetAlert:
            binding.showEmptySetAlert = true
          }
        }
        .store(in: &cancellables)
      
      self.input = input
      self.binding = binding
      self.output = output
    }
    
    func isPoemSelected(_ poemNumber: Int) -> Bool {
      return selectionLogic.isPoemSelected(poemNumber, settings: settings)
    }
    
    func refreshFromSettings() {
      output.selectedCount = settings.state100.selectedNum
    }
    
    // MARK: - Save Set Logic
    func saveNewFudaSet() {
      let result = saveLogic.saveNewFudaSet(name: binding.newSetName, settings: settings)

      if !result.successMessage.isEmpty {
        output.successMessage = result.successMessage
        binding.successAlertTitle = result.alertTitle
        binding.showSuccessAlert = true
      }
    }

    func overwriteExistingFudaSet() {
      let result = saveLogic.overwriteExistingFudaSet(
        at: binding.selectedOverwriteIndex,
        availableOverwriteSets: output.availableOverwriteSets,
        settings: settings
      )

      output.successMessage = result.successMessage
      binding.successAlertTitle = result.alertTitle
      binding.showSuccessAlert = true
    }

    func prepareNewSetCreation() {
      saveLogic.prepareNewSetCreation()
    }

    func prepareOverwriteSelection() {
      saveLogic.prepareOverwriteSelection()
    }
  }
}

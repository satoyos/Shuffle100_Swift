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
      let selectByGroup = PassthroughSubject<Void, Never>()
    }
    
    final class Binding: BindingObject {
      @Published var searchText: String = ""
      @Published var showActionSheet: Bool = false
    }
    
    final class Output: OutputObject {
      @Published var filteredPoems: [Poem] = []
      @Published var selectedCount: Int = 0
      @Published var isSearching: Bool = false
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
      self.saveLogic = PoemPickerView.ViewModel.SaveLogic()
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
    func prepareSave() -> PoemPickerSaveAction {
      output.availableOverwriteSets = settings.savedFudaSets
      return SaveLogic.handleSaveRequest(selectedCount: settings.state100.selectedNum)
    }

    func saveNewFudaSet(name: String) -> PoemPickerSaveResult {
      saveLogic.saveNewFudaSet(name: name, settings: settings)
    }

    func overwriteExistingFudaSet(at index: Int) -> PoemPickerSaveResult {
      saveLogic.overwriteExistingFudaSet(
        at: index,
        availableOverwriteSets: output.availableOverwriteSets,
        settings: settings
      )
    }
  }
}

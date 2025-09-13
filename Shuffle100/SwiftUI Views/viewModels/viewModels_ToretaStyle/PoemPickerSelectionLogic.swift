//
//  PoemPickerSelectionLogic.swift
//  Shuffle100
//
//  Created by Claude Code on 2025/09/05.
//  Copyright © 2025 里 佳史. All rights reserved.
//

import Foundation
import Combine

// MARK: - Selection Logic Protocol
protocol PoemPickerSelectionHandling {
  func selectPoem(_ poemNumber: Int, settings: Settings) -> Int
  func selectAllPoems(settings: Settings) -> Int
  func cancelAllPoems(settings: Settings) -> Int
  func filterPoems(by searchText: String) -> [Poem]
  func isPoemSelected(_ poemNumber: Int, settings: Settings) -> Bool
}

// MARK: - Selection Logic Implementation
extension PoemPickerView.ViewModel {
  
  final class SelectionLogic: PoemPickerSelectionHandling {
    
    func selectPoem(_ poemNumber: Int, settings: Settings) -> Int {
      let newState100 = settings.state100.reverseInNumber(poemNumber)
      settings.state100 = newState100
      return newState100.selectedNum
    }
    
    func selectAllPoems(settings: Settings) -> Int {
      let newState100 = settings.state100.selectAll()
      settings.state100 = newState100
      return newState100.selectedNum
    }
    
    func cancelAllPoems(settings: Settings) -> Int {
      let newState100 = settings.state100.cancelAll()
      settings.state100 = newState100
      return newState100.selectedNum
    }
    
    func filterPoems(by searchText: String) -> [Poem] {
      if searchText.isEmpty {
        return PoemSupplier.originalPoems
      } else {
        return PoemSupplier.originalPoems.filter { poem in
          poem.searchText.lowercased().contains(searchText.lowercased())
        }
      }
    }
    
    func isPoemSelected(_ poemNumber: Int, settings: Settings) -> Bool {
      do {
        return try settings.state100.ofNumber(poemNumber)
      } catch {
        return false
      }
    }
  }
  
  // MARK: - Combine Publishers Setup
  final class SelectionCombineSetup {
    
    static func setupSelectionPublishers(
      input: PoemPickerView.ViewModel.Input,
      binding: PoemPickerView.ViewModel.Binding,
      output: PoemPickerView.ViewModel.Output,
      settings: Settings,
      selectionLogic: PoemPickerSelectionHandling,
      cancellables: inout Set<AnyCancellable>
    ) {
      
      // 歌選択の処理
      input.selectPoem
        .sink { poemNumber in
          output.selectedCount = selectionLogic.selectPoem(poemNumber, settings: settings)
        }
        .store(in: &cancellables)
      
      // 検索テキストの処理
      binding.$searchText
        .removeDuplicates()
        .sink { searchText in
          output.isSearching = !searchText.isEmpty
          output.filteredPoems = selectionLogic.filterPoems(by: searchText)
        }
        .store(in: &cancellables)
      
      // 全選択の処理
      input.selectAll
        .sink { _ in
          output.selectedCount = selectionLogic.selectAllPoems(settings: settings)
        }
        .store(in: &cancellables)
      
      // 全取消の処理
      input.cancelAll
        .sink { _ in
          output.selectedCount = selectionLogic.cancelAllPoems(settings: settings)
        }
        .store(in: &cancellables)
    }
  }
}
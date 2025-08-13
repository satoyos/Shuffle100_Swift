//
//  FudaSetsView.ViewModel.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/01/12.
//  Copyright © 2025 里 佳史. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

extension FudaSetsView {
  final class ViewModel: ViewModelObject {
    
    final class Input: InputObject {
      let selectFudaSet = PassthroughSubject<Int, Never>()
      let deleteFudaSet = PassthroughSubject<IndexSet, Never>()
    }
    
    final class Binding: BindingObject {
    }
    
    final class Output: OutputObject {
      @Published var savedFudaSets: [SavedFudaSet] = []
      @Published var selectedState100: SelectedState100 = SelectedState100()
      @Published var selectedIndex: Int? = nil
    }
    
    let input: Input
    @BindableObject private(set) var binding: Binding
    let output: Output
    var cancellables: Set<AnyCancellable> = []
    
    init(savedFudaSets: [SavedFudaSet]) {
      let input = Input()
      let binding = Binding()
      let output = Output()
      
      output.savedFudaSets = savedFudaSets
      
      input.selectFudaSet
        .sink { index in
          guard index < output.savedFudaSets.count else { return }
          output.selectedState100 = output.savedFudaSets[index].state100
          output.selectedIndex = index
        }
        .store(in: &cancellables)
      
      input.deleteFudaSet
        .sink { indexSet in
          // 削除前に選択インデックスを調整
          if let selectedIndex = output.selectedIndex,
             indexSet.contains(selectedIndex) {
            output.selectedIndex = nil
          } else if let selectedIndex = output.selectedIndex {
            // 選択されたアイテムより前のアイテムが削除された場合、インデックスを調整
            let deletedCount = indexSet.filter { $0 < selectedIndex }.count
            output.selectedIndex = selectedIndex - deletedCount
          }
          output.savedFudaSets.remove(atOffsets: indexSet)
        }
        .store(in: &cancellables)
      
      self.input = input
      self.binding = binding
      self.output = output
    }
  }
}

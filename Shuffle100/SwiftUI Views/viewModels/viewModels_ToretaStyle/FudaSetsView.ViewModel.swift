//
//  FudaSetsView.ViewModel.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/01/12.
//  Copyright © 2025 里 佳史. All rights reserved.
//

import Foundation
import SwiftUI

extension FudaSetsView {
  class ViewModel: ObservableObject {
    private let settings: Settings
    private let saveAction: () -> Void
    
    // Computed property - Settingsの配列を直接参照
    var savedFudaSets: [SavedFudaSet] {
      settings.savedFudaSets
    }
    
    init(settings: Settings, saveAction: @escaping () -> Void) {
      self.settings = settings
      self.saveAction = saveAction
    }
    
    func selectFudaSet(at index: Int) {
      guard index < savedFudaSets.count else { return }
      settings.state100 = savedFudaSets[index].state100
      saveAction()
    }
    
    func deleteFudaSet(at offsets: IndexSet) {
      settings.savedFudaSets.remove(atOffsets: offsets)
      saveAction()
      // SwiftUIが自動的にUI更新するため、手動更新・@Published不要
    }
  }
}
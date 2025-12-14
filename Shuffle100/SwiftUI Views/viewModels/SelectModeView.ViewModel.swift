//
//  SelectModeView.ViewModel.swift
//  Shuffle100
//

import Foundation
import SwiftUI

extension SelectModeView {
  struct ViewModel {
    let settings: Settings
    let reciteModeHolders: [ReciteModeHolder]

    // SwiftUI Pickerの選択状態をSettingsと双方向バインド
    var selectedMode: Binding<ReciteMode> {
      Binding(
        get: { settings.reciteMode },
        set: { settings.reciteMode = $0 }
      )
    }

    init(settings: Settings, reciteModeHolders: [ReciteModeHolder]) {
      self.settings = settings
      self.reciteModeHolders = reciteModeHolders
    }
  }
}

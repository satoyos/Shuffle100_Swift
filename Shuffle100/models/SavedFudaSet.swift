//
//  File.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/05/31.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import Foundation

struct SavedFudaSet: Codable {
  var name: String
  var state100: SelectedState100
  
  init(name: String = "名前を付けましょう", state100: SelectedState100 = SelectedState100()) {
    self.name = name
    self.state100 = state100
  }
}

// MARK: - Preview Support
extension SavedFudaSet {
  static var previewSamples: [SavedFudaSet] {
    [
      SavedFudaSet(
        name: "春の歌セット",
        state100: createPreviewState(selectedCount: 25)
      ),
      SavedFudaSet(
        name: "恋の歌セット", 
        state100: createPreviewState(selectedCount: 40)
      ),
      SavedFudaSet(
        name: "自然の美しさ",
        state100: createPreviewState(selectedCount: 15)
      ),
      SavedFudaSet(
        name: "季節の移ろい",
        state100: createPreviewState(selectedCount: 60)
      )
    ]
  }
  
  private static func createPreviewState(selectedCount: Int) -> SelectedState100 {
    var boolArray = Bool100.allUnselected
    for i in 0..<min(selectedCount, 100) {
      boolArray[i] = true
    }
    return SelectedState100(bool100: boolArray)
  }
}

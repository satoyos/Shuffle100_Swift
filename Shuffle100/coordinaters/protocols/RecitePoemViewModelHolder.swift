//
//  RecitePoemViewModelHolder.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/12/07.
//  Copyright © 2025 里 佳史. All rights reserved.
//

import Foundation

/// RecitePoemBaseViewModelを保持・管理するプロトコル
protocol RecitePoemViewModelHolder: AnyObject {
  var currentRecitePoemBaseViewModel: RecitePoemBaseViewModel? { get set }
}

extension RecitePoemViewModelHolder {
  func getCurrentRecitePoemBaseViewModel() -> RecitePoemBaseViewModel? {
    return currentRecitePoemBaseViewModel
  }

  func setCurrentRecitePoemBaseViewModel(_ viewModel: RecitePoemBaseViewModel) {
    self.currentRecitePoemBaseViewModel = viewModel
  }
}

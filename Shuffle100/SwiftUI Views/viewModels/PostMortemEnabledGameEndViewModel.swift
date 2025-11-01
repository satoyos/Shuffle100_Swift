//
//  PostMortemEnabledGameEndViewModel.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/11/01.
//

import Foundation
import Combine

final class PostMortemEnabledGameEndViewModel: ObservableObject {
  @Published var showPostMortemConfirmation: Bool = false

  let backToHomeAction: () -> Void
  let startPostMortemAction: () -> Void

  init(backToHomeAction: @escaping () -> Void,
       startPostMortemAction: @escaping () -> Void) {
    self.backToHomeAction = backToHomeAction
    self.startPostMortemAction = startPostMortemAction
  }

  func requestPostMortem() {
    showPostMortemConfirmation = true
  }
}

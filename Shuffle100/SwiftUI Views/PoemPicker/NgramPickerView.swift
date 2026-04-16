//
//  NgremPickerView.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/05/17.
//

import SwiftUI

struct NgramPickerView {
  let settings: Settings
  @ObservedObject private var viewModel: NgramPickerViewModel

  init(settings: Settings) {
    self.settings = settings
    self.viewModel = .init(settings: settings)
  }
}

extension NgramPickerView: View {
  var body: some View {
    List {
      ForEach(NgramSections.default) { section in
        Section(header: Text(section.title)) {
          ForEach(section.firstChars) { char in
            NgramButton(viewModel: char.buttonViewModel) {
              viewModel.input.chrButotnTapped.send(char)
            }
          }
        }
      }
    }
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        BadgeView(number: viewModel.output.state100.selectedNum)
      }
    }
  }
}

#Preview {
  NgramPickerView(settings: Settings())
}

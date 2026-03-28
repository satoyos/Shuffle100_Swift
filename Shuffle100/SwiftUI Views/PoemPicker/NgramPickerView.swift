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
  @Environment(\.isPresented) private var isPresented

  init(settings: Settings) {
    self.settings = settings
    self.viewModel = .init(state100: settings.state100)
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
    .onChange(of: isPresented) {
      guard !isPresented else { return }
      tasksForLeavingThisView()
    }
  }
  
  func tasksForLeavingThisView() {
    settings.state100 = viewModel.output.state100
  }
}

#Preview {
  NgramPickerView(settings: Settings())
}

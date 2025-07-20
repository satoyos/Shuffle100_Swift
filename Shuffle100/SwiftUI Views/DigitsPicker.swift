//
//  DigitsPicker.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/07/19.
//

import SwiftUI

struct DigitsPicker<D: Digits> {
  let settings: Settings
  @ObservedObject private var viewModel: DigitsPickerViewModel<D>
  @Environment(\.isPresented) var isPresented
  
  init(settings: Settings) {
    self.settings = settings
    self.viewModel = .init(state100: settings.state100)
  }
}

extension DigitsPicker: View where D.AllCases: RandomAccessCollection {
  var body: some View {
    NavigationStack {
      List {
        ForEach(D.allCases) { digit in
          DigitsButton<D>(viewModel: digit.buttonViewModel) {
            viewModel.input.digitButtonTapped.send(digit)
          }
          .accessibilityIdentifier(digit.description)
        }
      }
      .toolbar {
        ToolbarItem(placement: .confirmationAction) {
          BadgeView(number: viewModel.selectedNum)
        }
        ToolbarItem(placement: .principal) {
          Text(D.description)
        }
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
  DigitsPicker<Digits01>(settings: Settings())
}

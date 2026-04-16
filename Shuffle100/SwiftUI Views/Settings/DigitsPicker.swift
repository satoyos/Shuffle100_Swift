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

  init(settings: Settings) {
    self.settings = settings
    self.viewModel = .init(settings: settings)
  }
}

extension DigitsPicker: View where D.AllCases: RandomAccessCollection {
  var body: some View {
    List {
      ForEach(D.allCases) { digit in
        DigitsButton<D>(viewModel: digit.buttonViewModel) {
          viewModel.input.digitButtonTapped.send(digit)
        }
        .accessibilityIdentifier(digit.description)
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
  DigitsPicker<Digits01>(settings: Settings())
}

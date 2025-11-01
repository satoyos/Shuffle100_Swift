//
//  RecitePlayButton.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2024/07/22.
//

import SwiftUI

struct RecitePlayButton {
  @ObservedObject var viewModel: ViewModel
  var diameteer: Double

  init(diameter: Double = 300, viewModel: ViewModel) {
    self.diameteer = diameter
    self.viewModel = viewModel
  }
}

extension RecitePlayButton: View {
  var body: some View {
    ReciteViewGeneralButton(type: viewModel.output.type, diameter: diameteer) {
      viewModel.input.playButtonTapped.send()
    }
  }
}

#Preview {
  RecitePlayButton(viewModel: RecitePlayButton.ViewModel(type: .play))
}

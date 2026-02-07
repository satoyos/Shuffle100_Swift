//
//  MemorizeTimer.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2024/07/27.
//

import SwiftUI

struct MemorizeTimer {
  @ObservedObject private var viewModel: ViewModel

  init(viewModel: ViewModel) {
    self.viewModel = viewModel
  }
}

extension MemorizeTimer: View {
  var body: some View {
    GeometryReader { geometry in
      VStack {
        MinSec(digitSize: digitSize(for: geometry), viewModel: viewModel.timeViewModel)
        RecitePlayButton(
          diameter: buttonDiameter(for: geometry),
          viewModel: viewModel.buttonViewModel)
        .disabled(viewModel.isButtonDisabled)
      }
      .frame(width: geometry.size.width, height: geometry.size.height)
    }
    .onAppear{
      UIApplication.shared.isIdleTimerDisabled = true
    }
    .onDisappear {
      UIApplication.shared.isIdleTimerDisabled = false
    }
  }

  private func buttonDiameter(for geometry: GeometryProxy) -> Double {
    geometry.size.width * 120.0 / 400.0
  }

  private func digitSize(for geometry: GeometryProxy) -> CGFloat {
    geometry.size.width * 100.0 / 500.0
  }
}

#Preview {
  MemorizeTimer(
    viewModel: .init(totalSec: 15 * 60,
                     completion: {print("** All finished **")}))
}

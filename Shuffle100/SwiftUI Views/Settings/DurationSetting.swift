//
//  DurationSetting.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/01/11.
//

import SwiftUI

struct DurationSetting {
  @ObservedObject private var viewModel: DurationSettingViewModel

  private let onDurationChanged: ((Double) -> Void)?

  init(viewModel: DurationSettingViewModel, onDurationChanged: ((Double) -> Void)? = nil) {
    self.viewModel = viewModel
    self.onDurationChanged = onDurationChanged
  }
}

extension DurationSetting: View {
  var body: some View {
    GeometryReader { geometry in
      VStack(spacing: digitSize(for: geometry) / 4) {
        Sec2F(digitSize: 100, viewModel: viewModel.timeViewModel)
        Slider(value: Binding(
          get: { viewModel.binding.startTime },
          set: { value in
            viewModel.binding.startTime = value
            onDurationChanged?(value)
          }
        ), in: 0.5 ... 2.0, step: 0.02 )
          .accessibilityIdentifier("slider")
          .padding(.horizontal)
          .disabled(viewModel.output.isUserActionDisabled)
        Button("試しに聞いてみる") {
          viewModel.input.startTrialCountDownRequest.send()
        }
        .buttonStyle(.borderedProminent)
        .foregroundStyle(Color.white)
        .padding(.top)
        .disabled(viewModel.output.isUserActionDisabled)
      }
      .frame(width: geometry.size.width, height: geometry.size.height)
    }
  }

  private func digitSize(for geometry: GeometryProxy) -> Double {
    geometry.size.width / 5.0
  }
}

#Preview {
  DurationSetting(viewModel: .init(
    durationType: .twoPoems,
    startTime: 1.1,
    singer: Singers.defaultSinger))
}

//
//  DurationSetting.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/01/11.
//

import SwiftUI

struct DurationSetting {
    @ObservedObject private var viewModel: DurationSettingViewModel
    @EnvironmentObject var screenSizeStore: ScreenSizeStore
    
    init(viewModel: DurationSettingViewModel) {
        self.viewModel = viewModel
    }
}

extension DurationSetting: View {
    var body: some View {
        VStack(spacing: digitSize / 4) {
            Sec2F(digitSize: 100, viewModel: viewModel.timeViewModel)
            Slider(value: viewModel.$binding.startTime, in: 0.5 ... 2.0, step: 0.02 )
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
    }
    
    private var digitSize: Double {
        screenSizeStore.screenWidth / 5.0
    }

}

#Preview {
    DurationSetting(viewModel: .init(
        durationType: .twoPoems,
        startTime: 1.1,
        singer: Singers.defaultSinger))
        .environmentObject(ScreenSizeStore())
}

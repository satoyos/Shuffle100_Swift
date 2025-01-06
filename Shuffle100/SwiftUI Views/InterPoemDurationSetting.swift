//
//  DurationSetting.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2024/08/24.
//

import SwiftUI

struct InterPoemDurationSetting {
    @ObservedObject private var viewModel: DurationSettingViewModel
    @EnvironmentObject var screenSizeStore: ScreenSizeStore
    let settings: Settings
    
    // To catch event: navigation back to Parent View of SwiftUI
    @Environment(\.isPresented) private var isPresented

    init(durationType: DurationSettingType, startTime: Double, settings: Settings) {
        self.viewModel = DurationSettingViewModel(
            durationType: durationType,
            startTime: startTime,
            singer: Singers.fetchSingerFrom(settings))
        self.settings = settings
    }
}

extension InterPoemDurationSetting: View {
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
        .onChange(of: isPresented) {
            guard !isPresented else { return }
            reflectSliderValueToSettings()
        }
    }
    
    func reflectSliderValueToSettings() {
        settings.interval = Float(viewModel.binding.startTime)
    }
    
    private var digitSize: Double {
        screenSizeStore.screenWidth / 5.0
    }
}

#Preview {
    InterPoemDurationSetting(durationType: .twoPoems, startTime: 1.1, settings: Settings())
        .environmentObject(ScreenSizeStore())
}

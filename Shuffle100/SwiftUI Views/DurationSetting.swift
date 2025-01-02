//
//  DurationSetting.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2024/08/24.
//

import SwiftUI

struct DurationSetting {
    @ObservedObject private var viewModel: DurationSettingViewModel
    @EnvironmentObject var screenSizeStore: ScreenSizeStore
    let settings: Settings
    

    @Environment(\.isPresented) private var isPresented

    init(startTime: Double, settings: Settings = .init()) {
        self.viewModel = DurationSettingViewModel(startTime: startTime, singer: Singers.fetchSingerFrom(settings))
        self.settings = settings
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
    DurationSetting(startTime: 1.1)
        .environmentObject(ScreenSizeStore())
}

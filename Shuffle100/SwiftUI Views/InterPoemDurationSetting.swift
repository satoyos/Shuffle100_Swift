//
//  DurationSetting.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2024/08/24.
//

import SwiftUI

struct InterPoemDurationSetting {
    let settings: Settings
    let viewModel: DurationSettingViewModel

    // To catch event: navigation back to Parent View of SwiftUI
    @Environment(\.isPresented) private var isPresented
    
    init(startTime: Double, settings: Settings) {
        self.viewModel = .init(
            durationType: .twoPoems,
            startTime: startTime,
            singer: Singers.fetchSingerFrom(settings))
        self.settings = settings
    }
}

extension InterPoemDurationSetting: View {
    var body: some View {
        DurationSetting(viewModel: viewModel)
        .onChange(of: isPresented) {
            guard !isPresented else { return }
            reflectSliderValueToSettings()
        }
    }
    
    func reflectSliderValueToSettings() {
        settings.interval = Float(viewModel.binding.startTime)
    }
}

#Preview {
    InterPoemDurationSetting(startTime: 1.1, settings: Settings())
        .environmentObject(ScreenSizeStore())
}

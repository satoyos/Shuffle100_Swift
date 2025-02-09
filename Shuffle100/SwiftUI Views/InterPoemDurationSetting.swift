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
    
  init(startTime givenTime: Float? = nil,
         settings: Settings) {
        let startTime = givenTime ?? settings.interval
        self.viewModel = .init(
            durationType: .twoPoems,
            startTime: Double(startTime),
            singer: Singers.fetchSingerFrom(settings))
        self.settings = settings
    }
}

extension InterPoemDurationSetting: View {
    var body: some View {
        DurationSetting(viewModel: viewModel)
        .onChange(of: isPresented) {
            guard !isPresented else { return }
            tasksForLeavingThisView()
        }
    }
  
    func tasksForLeavingThisView() {
        reflectSliderValueToSettings()
        viewModel.stopReciting()
    }
    
    private func reflectSliderValueToSettings() {
        settings.interval = Float(viewModel.binding.startTime)
    }
}

#Preview {
    InterPoemDurationSetting(startTime: 1.2,
                             settings: Settings())
        .environmentObject(ScreenSizeStore())
}

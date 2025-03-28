//
//  KamiShimoDurationSetting.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/01/03.
//  Copyright © 2025 里 佳史. All rights reserved.
//

import SwiftUI

struct KamiShimoDurationSetting {
  let settings: Settings
  let viewModel: DurationSettingViewModel
  
  // To catch event: navigation back to Parent View of SwiftUI
  @Environment(\.isPresented) private var isPresented
  
  init(startTime givenTime: Float? = nil,
       settings: Settings) {
    let startTime = givenTime ?? settings.kamiShimoInterval
    self.viewModel = .init(
      durationType: .kamiShimo,
      startTime: Double(startTime),
      singer: Singers.fetchSingerFrom(settings))
    self.settings = settings
  }
}

extension KamiShimoDurationSetting: View {
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
    settings.kamiShimoInterval = Float(viewModel.binding.startTime)
  }
}

#Preview {
  KamiShimoDurationSetting(startTime: 1.0, settings: Settings())
    .environmentObject(ScreenSizeStore())
}

//
//  ReciteSettingsRouter.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2026/01/04.
//  Copyright © 2026 里 佳史. All rights reserved.
//

import SwiftUI

@MainActor
class ReciteSettingsRouter: ObservableObject {
  @Published var path = NavigationPath()
  let settings: Settings

  init(settings: Settings) {
    self.settings = settings
  }

  @ViewBuilder
  func destination(for route: ReciteSettingsRoute) -> some View {
    switch route {
    case .intervalSetting:
      InterPoemDurationSetting(settings: settings)
        .environmentObject(ScreenSizeStore())
    case .kamiShimoIntervalSetting:
      KamiShimoDurationSetting(settings: settings)
        .environmentObject(ScreenSizeStore())
    case .volumeSetting:
      VolumeSetting(settings: settings)
    }
  }
}

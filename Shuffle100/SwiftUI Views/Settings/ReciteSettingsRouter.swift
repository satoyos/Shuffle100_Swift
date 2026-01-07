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
  let store: StoreManager
  let onSettingsChanged: (() -> Void)?

  init(settings: Settings, store: StoreManager, onSettingsChanged: (() -> Void)? = nil) {
    self.settings = settings
    self.store = store
    self.onSettingsChanged = onSettingsChanged
  }

  @ViewBuilder
  func destination(for route: ReciteSettingsRoute) -> some View {
    switch route {
    case .intervalSetting:
      let view = InterPoemDurationSetting(settings: settings)
      view
        .environmentObject(ScreenSizeStore())
        .navigationTitle("歌の間隔の調整")
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear { [weak self] in
          view.tasksForLeavingThisView()
          self?.saveSettings()
          self?.onSettingsChanged?()
        }
    case .kamiShimoIntervalSetting:
      let view = KamiShimoDurationSetting(settings: settings)
      view
        .environmentObject(ScreenSizeStore())
        .navigationTitle("上の句と下の句の間隔")
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear { [weak self] in
          view.tasksForLeavingThisView()
          self?.saveSettings()
          self?.onSettingsChanged?()
        }
    case .volumeSetting:
      let view = VolumeSetting(settings: settings)
      view
        .navigationTitle("音量の調整")
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear { [weak self] in
          view.tasksForLeavingThisView()
          self?.saveSettings()
          self?.onSettingsChanged?()
        }
    }
  }

  private func saveSettings() {
    do {
      try store.save(value: settings, key: Settings.userDefaultKey)
    } catch {
      assertionFailure("Settingsデータの保存に失敗しました。")
    }
  }
}

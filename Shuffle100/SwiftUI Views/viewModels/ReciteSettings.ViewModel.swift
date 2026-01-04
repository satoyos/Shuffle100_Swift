//
//  ReciteSettings.ViewModel.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2026/01/04.
//  Copyright © 2026 里 佳史. All rights reserved.
//

import SwiftUI

enum ReciteSettings {}

extension ReciteSettings {
  @MainActor
  class ViewModel: ObservableObject {
    let settings: Settings
    let store: StoreManager

    @Published var shortenJoka: Bool
    @Published var postMortemEnabled: Bool
    @Published var sections: [ReciteSettingsSection]

    init(settings: Settings, store: StoreManager) {
      self.settings = settings
      self.store = store
      self.shortenJoka = settings.shortenJoka
      self.postMortemEnabled = settings.postMortemEnabled
      self.sections = []
      buildSections()
    }

    private func buildSections() {
      sections = [
        ReciteSettingsSection(
          title: "読み上げの間隔",
          rows: [
            ReciteSettingsDataSource(
              title: "歌と歌の間隔",
              value: String(format: "%.2F秒", settings.interval),
              route: .intervalSetting
            ),
            ReciteSettingsDataSource(
              title: "上の句と下の句の間隔",
              value: String(format: "%.2F秒", settings.kamiShimoInterval),
              route: .kamiShimoIntervalSetting
            )
          ]
        ),
        ReciteSettingsSection(
          title: "音量",
          rows: [
            ReciteSettingsDataSource(
              title: "音量調整",
              value: "\(Int(settings.volume * 100))%",
              route: .volumeSetting
            )
          ]
        )
      ]
    }

    func refreshSections() {
      buildSections()
    }

    var shortenJokaBinding: Binding<Bool> {
      Binding(
        get: { self.shortenJoka },
        set: { newValue in
          self.shortenJoka = newValue
          self.settings.shortenJoka = newValue
          self.saveSettings()
        }
      )
    }

    var postMortemEnabledBinding: Binding<Bool> {
      Binding(
        get: { self.postMortemEnabled },
        set: { newValue in
          self.postMortemEnabled = newValue
          self.settings.postMortemEnabled = newValue
          self.saveSettings()
        }
      )
    }

    private func saveSettings() {
      do {
        try store.save(value: settings, key: Settings.userDefaultKey)
      } catch {
        assertionFailure("Settingsデータの保存に失敗しました。")
      }
    }
  }
}

//
//  SaveSettingsProtocol.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/07/23.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import Foundation

protocol SaveSettings {
  var settings: Settings { get set }
  var store: StoreManager { get set }
  func saveSettingsPermanently(_ settings: Settings, into store: StoreManager) -> Void
}

extension SaveSettings {
  func saveSettingsPermanently(_ settings: Settings, into store: StoreManager) {
    do {
      try store.save(value: settings, key: Settings.userDefaultKey)
    } catch {
      assertionFailure("SettingsデータのUserDefautへの保存に失敗しました。")
    }
  }
}

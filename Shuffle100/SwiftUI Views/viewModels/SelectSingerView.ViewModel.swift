//
//  SelectSingerView.ViewModel.swift
//  Shuffle100
//

import Foundation
import SwiftUI

extension SelectSingerView {
  struct ViewModel {
    let settings: Settings
    let singers: [Singer]

    // SwiftUI Pickerの選択状態をSettingsと双方向バインド
    var selectedSingerID: Binding<String> {
      Binding(
        get: { settings.singerID },
        set: { settings.singerID = $0 }
      )
    }

    // 音声ファイル検証メソッド（ビジネスロジック）
    func validateSingerSelection(_ singerID: String) -> ValidationResult {
      guard let singer = Singers.getSingerOfID(singerID) else {
        return .valid
      }

      if singer.id == "inaba" && !singer.hasRequiredAudioFiles() {
        return .invalid(
          title: "音声ファイルが見つかりません",
          message: "読み手として「いなばくん」を選ぶには、必要な音声ファイルを入手して `resources/audio/inaba/` フォルダに配置してください。現在はIA（ボーカロイド）を選択します。"
        )
      }

      return .valid
    }

    enum ValidationResult {
      case valid
      case invalid(title: String, message: String)

      var isInvalid: Bool {
        if case .invalid = self { return true }
        return false
      }
    }

    init(settings: Settings, singers: [Singer]) {
      self.settings = settings
      self.singers = singers
    }
  }
}

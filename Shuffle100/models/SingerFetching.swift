//
//  SingerFetching.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/01/01.
//  Copyright © 2025 里 佳史. All rights reserved.
//

extension Singers {
  enum SelectionValidationResult {
    case valid
    case invalid(title: String, message: String)

    var isInvalid: Bool {
      if case .invalid = self { return true }
      return false
    }
  }

  static func fetchSingerFrom(_ settings: Settings) -> Singer {
    guard let singer = Self.getSingerOfID(settings.singerID) else {
      fatalError("Singer of ID \(settings.singerID) is not found.")
    }
    return singer
  }

  /// 読手として選択できるかを検証する。
  ///
  /// 現在は、追加配布の音声ファイルが必要な「いなばくん」だけを検証対象とする。
  static func validateSelection(of singerID: String) -> SelectionValidationResult {
    guard let singer = Self.getSingerOfID(singerID) else {
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
}

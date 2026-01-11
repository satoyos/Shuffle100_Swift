//
//  HelpList.ViewModel.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2026/01/04.
//  Copyright © 2026 里 佳史. All rights reserved.
//

import Foundation

enum HelpList {}

extension HelpList {
  @MainActor
  class ViewModel: ObservableObject {
    @Published var sections: [HelpListSection]

    var dismissAction: (() -> Void)?

    init() {
      self.sections = [
        HelpListSection(name: "使い方", dataSources: [
          HelpListDataSource(name: "設定できること", type: .html, fileName: "html/options"),
          HelpListDataSource(name: "試合の流れ (通常モード)", type: .html, fileName: "html/game_flow"),
          HelpListDataSource(name: "「初心者モード」とは？", type: .html, fileName: "html/what_is_beginner_mode"),
          HelpListDataSource(name: "試合の流れ (初心者モード)", type: .html,  fileName: "html/beginner_mode_flow"),
          HelpListDataSource(name: "「ノンストップ・モード」とは？", type: .html, fileName: "html/what_is_nonstop_mode"),
          HelpListDataSource(name: "「下の句かるたモード」とは？", type: .html, fileName: "html/what_is_hokkaido_mode"),
          HelpListDataSource(name: "「札セット」とその使い方", type: .html, fileName: "html/fuda_set"),
          HelpListDataSource(name: "五色百人一首", type: .html, fileName: "html/five_colors"),
          HelpListDataSource(name: "「暗記時間タイマー」の使い方", type: .html, fileName: "html/memorize_timer"),
          HelpListDataSource(name: "「感想戦」のサポート", type: .html, fileName: "html/postmortem")
        ]),
        HelpListSection(name: "その他", dataSources: [
          HelpListDataSource(name: "「いなばくん」について", type: .html, fileName: "html/about_inaba_kun"),
          HelpListDataSource(name: "このアプリを評価する", type: .review, fileName: nil),
          HelpListDataSource(name: "バージョン", type: .value1, fileName: nil, detail: Self.appVersion())
        ])
      ]
    }

    private static func appVersion() -> String {
      let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
      return version
    }
  }
}

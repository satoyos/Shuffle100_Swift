//
//  ReciteSettingsView.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2026/01/04.
//  Copyright © 2026 里 佳史. All rights reserved.
//

import SwiftUI

struct ReciteSettingsView: View {
  @ObservedObject var viewModel: ReciteSettings.ViewModel
  @StateObject private var router: ReciteSettingsRouter

  init(viewModel: ReciteSettings.ViewModel) {
    self.viewModel = viewModel
    _router = StateObject(wrappedValue: ReciteSettingsRouter(
      settings: viewModel.settings,
      store: viewModel.store,
      onSettingsChanged: { [weak viewModel] in
        viewModel?.refreshSections()
      }
    ))
  }

  var body: some View {
    NavigationStack(path: $router.path) {
      List {
        // セクション1: 読み上げの間隔
        intervalSection()

        // セクション2: 音量
        volumeSection()

        // セクション3: 試合のモードあれこれ
        modeSection()
      }
      .listStyle(.insetGrouped)
      .navigationTitle("いろいろな設定")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("設定終了") {
            viewModel.dismissAction?()
          }
        }
      }
      .toolbarBackground(Color(uiColor: StandardColor.barTintColor), for: .navigationBar)
      .toolbarBackground(.visible, for: .navigationBar)
      .navigationDestination(for: ReciteSettingsRoute.self) { route in
        router.destination(for: route)
      }
      .onChange(of: router.path) { _, _ in
        // 詳細画面から戻ってきたとき値を更新
        viewModel.refreshSections()
      }
    }
  }

  @ViewBuilder
  private func intervalSection() -> some View {
    Section(header: Text("読み上げの間隔")) {
      ForEach(viewModel.sections[0].rows, id: \.self) { row in
        NavigationLink(value: row.route) {
          HStack {
            Text(row.title)
            Spacer()
            Text(row.value)
              .foregroundColor(.secondary)
          }
        }
      }
    }
  }

  @ViewBuilder
  private func volumeSection() -> some View {
    Section(header: Text("音量")) {
      ForEach(viewModel.sections[1].rows, id: \.self) { row in
        NavigationLink(value: row.route) {
          HStack {
            Text(row.title)
            Spacer()
            Text(row.value)
              .foregroundColor(.secondary)
          }
        }
      }
    }
  }

  @ViewBuilder
  private func modeSection() -> some View {
    Section(header: Text("試合のモードあれこれ")) {
      VStack(alignment: .leading, spacing: 4) {
        Toggle("序歌の読み上げ時間を短縮", isOn: viewModel.shortenJokaBinding)
        Text("序歌は、下の句を1回だけ読み上げます。")
          .font(.caption)
          .foregroundColor(.secondary)
      }

      VStack(alignment: .leading, spacing: 4) {
        Toggle("試合後に感想戦を選択できる", isOn: viewModel.postMortemEnabledBinding)
        Text("感想戦では、同じ歌を同じ順序で読み上げます。")
          .font(.caption)
          .foregroundColor(.secondary)
      }
    }
  }
}

#Preview {
  ReciteSettingsView(
    viewModel: ReciteSettings.ViewModel(
      settings: Settings(),
      store: StoreManager()
    )
  )
}

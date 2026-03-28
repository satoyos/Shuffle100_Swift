//
//  AppRootView.swift
//  Shuffle100
//
//  Phase 1: HomeViewを組み込み、SceneDelegateから起動する。
//  Phase 2: SelectMode/SelectSinger/MemorizeTimerを追加。
//  シート（ReciteSettings, Help）も実装済み。
//  Push先の各destinationはPhase 2以降で順次追加する。
//

import SwiftUI

struct AppRootView: View {
  @EnvironmentObject var router: AppRouter

  var body: some View {
    NavigationStack(path: $router.path) {
      HomeView()
        .navigationDestination(for: AppRoute.self) { route in
          destination(for: route)
        }
    }
    .sheet(item: $router.sheetRoute) { route in
      sheetContent(for: route)
    }
    .onAppear {
      AudioPlayerFactory.shared.setupAudioSession()
    }
  }

  // MARK: - Push destinations (Phase 2〜4で順次実装)

  @ViewBuilder
  private func destination(for route: AppRoute) -> some View {
    switch route {
    case .selectMode:
      SelectModeView(viewModel: .init(
        settings: router.settings,
        reciteModeHolders: Self.reciteModes
      ))
      .onDisappear { router.saveSettings() }
      .standardToolbarBackground()

    case .selectSinger:
      SelectSingerView(viewModel: .init(
        settings: router.settings,
        singers: Singers.all
      ))
      .onDisappear { router.saveSettings() }
      .standardToolbarBackground()

    case .memorizeTimer:
      MemorizeTimer(viewModel: .init(
        totalSec: 15 * 60,
        completion: { router.pop() }
      ))
      .navigationTitle("暗記時間タイマー")
      .standardToolbarBackground()

    case .poemPicker:
      PoemPickerView(settings: router.settings)
        .navigationTitle("歌を選ぶ")
        .onDisappear { router.saveSettings() }
        .standardToolbarBackground()

    case .ngramPicker:
      NgramPickerView(settings: router.settings)
        .navigationTitle("1字目で選ぶ")
        .onDisappear { router.saveSettings() }
        .standardToolbarBackground()

    default:
      // Phase 4で実装を追加していく
      Text("未実装: \(String(describing: route))")
        .navigationTitle(String(describing: route))
        .standardToolbarBackground()
    }
  }

  private static let reciteModes: [ReciteModeHolder] = [
    ReciteModeHolder(mode: .normal,   title: "通常 (競技かるた)"),
    ReciteModeHolder(mode: .beginner, title: "初心者 (チラし取り)"),
    ReciteModeHolder(mode: .nonstop,  title: "ノンストップ (止まらない)"),
    ReciteModeHolder(mode: .hokkaido, title: "下の句かるた (北海道式)")
  ]

  // MARK: - Sheet destinations

  @ViewBuilder
  private func sheetContent(for route: SheetRoute) -> some View {
    switch route {
    case .help:
      HelpSheetWrapper()
    case .reciteSettings:
      ReciteSettingsSheetWrapper(
        settings: router.settings,
        store: router.store
      )
    case .torifuda(let poem):
      // Phase 3で実装
      Text("取り札未実装: \(poem.number)")
    case .whatsNext(let poem):
      // Phase 4で実装
      Text("次はどうする未実装: \(poem.number)")
    }
  }
}

// MARK: - Sheet wrappers

/// HelpListViewをシートとして表示するためのラッパー
private struct HelpSheetWrapper: View {
  @Environment(\.dismiss) private var dismiss
  @StateObject private var viewModel = HelpList.ViewModel()

  var body: some View {
    HelpListView(viewModel: viewModel)
      .onAppear {
        viewModel.dismissAction = { dismiss() }
      }
  }
}

// MARK: - Toolbar helper

private extension View {
  func standardToolbarBackground() -> some View {
    self
      .toolbarBackground(Color(uiColor: StandardColor.barTintColor), for: .navigationBar)
      .toolbarBackground(.visible, for: .navigationBar)
  }
}

/// ReciteSettingsViewをシートとして表示するためのラッパー
private struct ReciteSettingsSheetWrapper: View {
  @Environment(\.dismiss) private var dismiss
  @StateObject private var viewModel: ReciteSettings.ViewModel

  init(settings: Settings, store: StoreManager) {
    _viewModel = StateObject(
      wrappedValue: ReciteSettings.ViewModel(settings: settings, store: store)
    )
  }

  var body: some View {
    ReciteSettingsView(viewModel: viewModel)
      .onAppear {
        viewModel.dismissAction = { dismiss() }
      }
  }
}

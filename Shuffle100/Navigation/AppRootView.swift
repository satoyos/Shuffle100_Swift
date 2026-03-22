//
//  AppRootView.swift
//  Shuffle100
//
//  Phase 1: HomeViewを組み込み、SceneDelegateから起動する。
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
    // 各フェーズで実装を追加していく
    Text("未実装: \(String(describing: route))")
      .navigationTitle(String(describing: route))
  }

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

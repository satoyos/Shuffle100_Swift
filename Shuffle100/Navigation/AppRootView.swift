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

    case .fudaSets:
      FudaSetsView(settings: router.settings)
        .navigationTitle("作った札セットから選ぶ")
        .onDisappear { router.saveSettings() }
        .standardToolbarBackground()

    case .fiveColors:
      FiveColorsView(settings: router.settings)
        .navigationTitle("五色百人一首")
        .onDisappear { router.saveSettings() }
        .standardToolbarBackground()

    case .digitsPicker01:
      DigitsPicker<Digits01>(settings: router.settings)
        .navigationTitle(Digits01.description)
        .onDisappear { router.saveSettings() }
        .standardToolbarBackground()

    case .digitsPicker10:
      DigitsPicker<Digits10>(settings: router.settings)
        .navigationTitle(Digits10.description)
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
      TorifudaSheetWrapper(poem: poem)
    case .whatsNext(let poem):
      WhatsNextSheetWrapper(
        poem: poem,
        settings: router.settings,
        store: router.store
      )
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

/// TorifudaViewをシートとして表示するためのラッパー
private struct TorifudaSheetWrapper: View {
  @Environment(\.dismiss) private var dismiss
  let poem: Poem

  private var title: String {
    "\(poem.number). " + poem.liner.joined(separator: " ")
  }

  var body: some View {
    NavigationStack {
      TorifudaView(
        shimoStr: poem.in_hiragana.shimo,
        fullLiner: poem.liner
      )
      .navigationTitle(title)
      .navigationBarTitleDisplayMode(.inline)
      .toolbarBackground(Color(uiColor: StandardColor.barTintColor), for: .navigationBar)
      .toolbarBackground(.visible, for: .navigationBar)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            dismiss()
          } label: {
            Image(systemName: "xmark")
          }
          .accessibilityLabel("閉じる")
        }
      }
    }
  }
}

/// WhatsNextView (「次はどうする?」画面) をシートとして表示するためのラッパー。
///
/// - 下の句をもう一度 / 次の歌へ / 終了 は GameStateManager 経由で処理。
///   WhatsNextView 内で .dismiss() されるため、シート自体は自動で閉じる。
/// - 取り札を見る / 歯車 (読み上げ設定) は WhatsNext シートの上に
///   ネストしたシートとして表示する (WhatsNext は閉じない)。
private struct WhatsNextSheetWrapper: View {
  @EnvironmentObject private var router: AppRouter
  @Environment(\.dismiss) private var dismiss

  let poem: Poem
  @StateObject private var viewModel: WhatsNextViewModel
  private let reciteSettings: Settings
  private let store: StoreManager

  @State private var showingTorifuda = false
  @State private var showingReciteSettings = false

  init(poem: Poem, settings: Settings, store: StoreManager) {
    self.poem = poem
    self.reciteSettings = settings
    self.store = store
    _viewModel = StateObject(wrappedValue: WhatsNextViewModel(currentPoem: poem))
  }

  var body: some View {
    NavigationStack {
      WhatsNextView(viewModel: viewModel)
    }
    .onAppear {
      viewModel.showTorifudaAction = {
        showingTorifuda = true
      }
      viewModel.refrainAction = { [weak router] in
        router?.gameStateManager?.handleRefrainShimo()
      }
      viewModel.goNextAction = { [weak router] in
        router?.gameStateManager?.handleGoNext()
      }
      viewModel.goSettingAction = {
        showingReciteSettings = true
      }
      viewModel.backToHomeScreenAction = { [weak router] in
        router?.gameStateManager?.handleExitGame()
      }
    }
    // 取り札を見る (ネストしたシート)
    .sheet(isPresented: $showingTorifuda) {
      TorifudaSheetWrapper(poem: poem)
    }
    // 歯車 → 読み上げ設定 (ネストしたシート)
    .sheet(isPresented: $showingReciteSettings) {
      ReciteSettingsSheetWrapper(settings: reciteSettings, store: store)
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

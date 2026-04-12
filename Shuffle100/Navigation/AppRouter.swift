//
//  AppRouter.swift
//  Shuffle100
//

import SwiftUI

@MainActor
class AppRouter: ObservableObject {
  @Published var path = NavigationPath()
  @Published var sheetRoute: SheetRoute? = nil

  let settings: Settings
  let store: StoreManager

  /// 現在ゲーム中の GameStateManager。GamePlayView が onAppear で設定する。
  /// WhatsNextSheetWrapper などゲーム画面配下のシートから参照するために持つ。
  /// (Phase 5 で MainCoordinator を削除後、より綺麗な形に整理予定)
  var gameStateManager: GameStateManager?

  init(settings: Settings, store: StoreManager) {
    self.settings = settings
    self.store = store
  }

  /// StoreManagerからSettingsをロードして初期化する
  convenience init(store: StoreManager) {
    self.init(settings: Self.loadSettings(store: store), store: store)
  }

  // MARK: - Settings loading (MainCoordinatorSetUpSettings と同等のロジック)

  static func loadSettings(store: StoreManager) -> Settings {
    let env = SHEnvironment()
    let defaultSettings = Settings()
    guard !env.ignoreSavedData() else { return defaultSettings }
    guard let loadedSettings = store.load(key: Settings.userDefaultKey) as Settings? else {
      return defaultSettings
    }
    loadedSettings.fixOptionalProperties()
    return loadedSettings
  }

  func push(_ route: AppRoute) {
    path.append(route)
  }

  func pop() {
    guard !path.isEmpty else { return }
    path.removeLast()
  }

  func popToRoot() {
    path = NavigationPath()
  }

  func presentSheet(_ route: SheetRoute) {
    sheetRoute = route
  }

  func dismissSheet() {
    sheetRoute = nil
  }

  func saveSettings() {
    do {
      try store.save(value: settings, key: Settings.userDefaultKey)
    } catch {
      assertionFailure("SettingsデータのUserDefaultsへの保存に失敗しました。")
    }
  }
}

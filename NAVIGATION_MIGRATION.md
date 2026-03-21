# SwiftUI NavigationPath への段階的移行計画

## Context

現在のアプリはUINavigationControllerベースのCoordinatorパターンを採用している。これをSwiftUIのNavigationStackとNavigationPathに移行する。目的はUIKit依存の削減とSwiftUIネイティブなナビゲーション管理への統一。段階的に移行し、各フェーズ後にアプリが正常動作することを確認しながら進める。

## 現状の整理

### 遷移の種類
- **Push (UINavigationController)**: HomeScreen → SelectMode, SelectSinger, PoemPicker, MemorizeTimer, GameMode
- **Present (モーダル)**: ReciteSettings, HelpList, Torifuda, WhatsNext
- **NavigationPath（既存）**: HelpListView内（HelpRouter）、ReciteSettingsView内（ReciteSettingsRouter）

### Coordinator一覧（22個）
MainCoordinator, PoemPickerCoordinator, NgramPickerCoordinator, FudaSetsCoordinator, FiveColorsCoordinator, DigitsPickerScreen01Coordinator, DigitsPickerScreen10Coordinator, SelectModeCoordinator, SelectSingerCoordinator, NormalModeCoordinator, BeginnerModeCoordinator, NonsotpModeCoordinator, HokkaidoModeCoordinator, ReciteSettingsCoordinator, IntervalSettingCoordinator, KamiShimoIntervalSettingCoordinator, VolumeSettingCoordinator, HelpListCoordinator, TorifudaCoordinator, WhatsNextCoordinator, MemorizeTimerCoordinator

---

## 設計: AppRouter / AppRoute

```swift
// AppRoute.swift
enum AppRoute: Hashable {
  case selectMode
  case selectSinger
  case poemPicker
  case memorizeTimer
  case normalMode
  case beginnerMode
  case nonstopMode
  case hokkaidoMode
}

enum SheetRoute: Identifiable {
  case reciteSettings
  case help
  case torifuda(Poem)
  case whatsNext(Poem)
  var id: String { ... }
}

// AppRouter.swift
@MainActor
class AppRouter: ObservableObject {
  @Published var path = NavigationPath()
  @Published var sheetRoute: SheetRoute? = nil
  var settings: Settings
  var store: StoreManager

  func push(_ route: AppRoute) { path.append(route) }
  func pop() { guard !path.isEmpty else { return }; path.removeLast() }
  func popToRoot() { path = NavigationPath() }
  func presentSheet(_ route: SheetRoute) { sheetRoute = route }
  func dismissSheet() { sheetRoute = nil }
}
```

---

## Phase 0: 準備（新規ファイル追加のみ）

**ステータス**: 未着手

**目標**: 既存コードを壊さず、新しいルーティング基盤のファイルだけを追加。

**新規作成ファイル**:
- `Shuffle100/AppRoute.swift`
- `Shuffle100/AppRouter.swift`
- `Shuffle100/SheetRoute.swift`
- `Shuffle100/AppRootView.swift`（空のNavigationStack + 各destinationの骨格のみ）

**変更ファイル**: なし

**テスト確認**: ビルドが通り、既存の動作がすべて維持されること。

---

## Phase 1: HomeScreenのSwiftUI化とルート切り替え

**ステータス**: 未着手

**目標**: SceneDelegateのルートをUINavigationController+MainCoordinatorからNavigationStack+AppRouterへ切り替え。HomeScreenをSwiftUI化。

**変更内容**:
1. **`HomeView.swift`（新規）**: `HomeScreen.swift`のUITableViewをSwiftUIのListで再現。settingsはAppRouterから取得。gearボタン/helpボタンは`.toolbar`で実装。
2. **`SceneDelegate.swift`**: `UINavigationController`と`MainCoordinator`を廃止し、`UIHostingController<AppRootView>`に切り替え。`AspectRatioContainerViewController`は引き続き使用:
   ```swift
   let rootView = AppRootView().environmentObject(AppRouter(settings: ..., store: ...))
   let hostController = UIHostingController(rootView: rootView)
   let container = AspectRatioContainerViewController(child: hostController)
   window?.rootViewController = container
   ```
3. **`AppRootView.swift`**: `NavigationStack(path: $router.path) { HomeView() }` + `.sheet(item: $router.sheetRoute)`を実装。
4. **`MainCoordinator.swift`**: 廃止（このフェーズでは空スタブにし、Phase 5で削除）。

**廃止するCoordinator**: MainCoordinator

**テスト確認**:
- トップ画面が表示される
- 各セルに設定値（モード名、読み手名、歌数）が表示される
- gearボタン・helpボタンが表示される（まだ遷移しなくてよい）

---

## Phase 2: 設定系画面の移行

**ステータス**: 未着手

**目標**: シンプルな設定系のpush画面をNavigationPathに移行。Coordinatorが薄く、リスクが最も低い。

**対象画面**: SelectMode, SelectSinger, MemorizeTimer

**変更内容**:
1. `AppRoute.swift`に`.selectMode`, `.selectSinger`, `.memorizeTimer`を追加
2. `AppRootView.swift`の`navigationDestination`に各routeの遷移先を追加:
   - `.selectMode` → `SelectModeView(...)`
   - `.selectSinger` → `SelectSingerView(...)`
   - `.memorizeTimer` → `MemorizeTimer(...)`
3. `HomeView.swift`のセルタップ時に`router.push(.selectMode)`等を呼ぶ
4. 各SwiftUIビューで設定保存を`.onDisappear`で行う（現在は`ActionAttachedHostingController.actionForViewWillDissappear`で行っているため）

**廃止するCoordinator**: SelectModeCoordinator, SelectSingerCoordinator, MemorizeTimerCoordinator

**テスト確認**:
- 各設定画面に遷移し、戻れる
- 設定変更後にトップ画面の表示値が更新される
- UIテスト: `SelectSingerPage`関連のテストが通ること

---

## Phase 3: PoemPicker系の移行

**ステータス**: 未着手

**目標**: PoemPickerとその子画面（NgramPicker, FudaSets, FiveColors, DigitsPicker）を移行。

**技術的課題**:
- `PoemPickerView`は現在内部に`NavigationStack`を持っているため、外す必要がある
- 子画面へのボタンアクションをCoordinatorのクロージャから`AppRouter.push()`に変更

**変更内容**:
1. `AppRoute.swift`に`.poemPicker`, `.ngramPicker`, `.fudaSets`, `.fiveColors`, `.digitsPicker01`, `.digitsPicker10`を追加
2. `PoemPickerView.swift`から内部の`NavigationStack {}`を除去
3. 各子画面への遷移を`router.push(...)`で実装
4. `TorifudaCoordinator`の代わりに`router.presentSheet(.torifuda(poem))`で表示
5. `AppRootView.swift`の`navigationDestination`と`.sheet`に追加

**廃止するCoordinator**: PoemPickerCoordinator, NgramPickerCoordinator, FudaSetsCoordinator, FiveColorsCoordinator, DigitsPickerScreen01Coordinator, DigitsPickerScreen10Coordinator, TorifudaCoordinator

**テスト確認**:
- 歌を選ぶ画面に遷移できる
- 各絞り込み画面に遷移し、戻れる
- 取り札表示がシートで出る
- UIテスト: NgramPicker, DigitsPickerのテストが通ること

---

## Phase 4: ゲームモード画面の移行（最難関）

**ステータス**: 未着手

**目標**: RecitePoemBaseView + 4つのゲームモード、WhatsNextViewを移行。

**技術的課題**:
現在のCoordinatorはクロージャ（`playerFinishedAction`, `skipToNextScreenAction`）を動的に書き換えることで状態機械を実現している。これをSwiftUIの`ObservableObject`に移行する。

**GamePhase enumで状態を明示化**:
```swift
enum GamePhase {
  case joka
  case kami(poemNumber: Int, counter: Int)
  case waitingForPlay(poemNumber: Int, counter: Int)  // Normal mode: ユーザーのタップ待ち
  case shimo(poemNumber: Int, counter: Int)
  case whatsNext(poem: Poem, counter: Int)
  case gameEnd
}
```

**GameStateManagerでCoordinatorの状態機械を代替**:
- `KamiShimoRecitation`プロトコルの責務を`GameStateManager`に内包
- モード別の差異はStrategyパターン（`GameStrategy`プロトコル）で吸収
- `router.popToRoot()`や`router.presentSheet(.whatsNext(poem))`でナビゲーションを制御

**CATransactionの問題**: 現在「push完了後に序歌再生」をCATransactionで実現。NavigationStack移行後は`.onAppear`内の`Task.sleep`で代替:
```swift
.onAppear {
  Task {
    try? await Task.sleep(for: .milliseconds(400))
    gameStateManager.startJoka()
  }
}
```

**WhatsNextView**: 移行後は`router.presentSheet(.whatsNext(poem))`で`.sheet`として表示。

**ReciteSettings（ゲーム中）**: 既にReciteSettingsRouterがNavigationPathを使用しているため、`router.presentSheet(.reciteSettings)`を呼ぶだけ。

**廃止するCoordinator**: NormalModeCoordinator, BeginnerModeCoordinator, NonsotpModeCoordinator, HokkaidoModeCoordinator, WhatsNextCoordinator, ReciteSettingsCoordinator, IntervalSettingCoordinator, KamiShimoIntervalSettingCoordinator, VolumeSettingCoordinator, HelpListCoordinator

**Phase 4開始前の確認事項**:
1. `KamiShimoRecitation.swift`での`playerFinishedAction`書き換えの全パターン
2. `PoemSupplier`のライフサイクル（NavigationStack popでdeinitされるかどうか）
3. `Settings`オブジェクトの`@EnvironmentObject`注入でのライフサイクル整合性
4. `UIApplication.shared.isIdleTimerDisabled = true`の設定箇所と管理方法

**テスト確認**:
- 各ゲームモードで試合開始できる
- 序歌が再生される
- 上の句→下の句→次の歌の自動遷移が動く
- 初心者モード/北海道モードで「次はどうする?」シートが出る
- ゲーム終了画面が出る
- 感想戦が動く
- UIテスト: AllPoemRecitedPageのテストが通ること

---

## Phase 5: クリーンアップ

**ステータス**: 未着手

**目標**: 残存するCoordinatorとUIKit依存を完全削除。AspectRatioContainerViewControllerのSwiftUI化。

**AspectRatioContainerViewControllerのSwiftUI化**:
```swift
struct AspectRatioContainer<Content: View>: View {
  let content: Content
  var body: some View {
    GeometryReader { geo in
      let isLandscape = geo.size.width > geo.size.height
      let maxWidth = isLandscape ? geo.size.height * (3.0 / 4.0) : geo.size.width
      let xOffset = isLandscape ? (geo.size.width - maxWidth) / 2 : 0
      content
        .frame(width: maxWidth, height: geo.size.height)
        .offset(x: xOffset)
        .frame(width: geo.size.width, height: geo.size.height)
    }
  }
}
```

**削除ファイル**:
- `coordinaters/`内の全Coordinatorファイル
- `coordinaters/protocols/`内の全プロトコルファイル
- `coordinaters/supports/ActionAttachedHostingController.swift`
- `Screens/HomeScreen.swift`と関連ファイル
- `UIKit views/AspectRatioContainerViewController.swift`

**テスト確認**:
- 全UIテストが通ること
- iPad横向き時にアスペクト比4:3が保たれること

---

## 重要ファイル一覧

| 優先度 | ファイル | 理由 |
|--------|---------|------|
| 最重要 | `Shuffle100/coordinaters/MainCoordinator.swift` | Phase 1で廃止する全体像 |
| 最重要 | `Shuffle100/SceneDelegate.swift` | Phase 1でエントリポイント切り替え |
| 最重要 | `Shuffle100/coordinaters/protocols/KamiShimoRecitation.swift` | GameStateManagerへの置き換えの起点 |
| 重要 | `Shuffle100/SwiftUI Views/viewModels/viewModels_ToretaStyle/RecitePoemBaseViewModel.swift` | playerFinishedActionのクロージャパターン |
| 重要 | `Shuffle100/coordinaters/WhatsNextCoordinator.swift` | 別UINavigationControllerパターン |
| 重要 | `Shuffle100/SwiftUI Views/PoemPicker/PoemPickerView.swift` | 内部NavigationStack除去対象 |
| 参照 | `Shuffle100/SwiftUI Views/Help/HelpRouter.swift` | NavigationPath実装の参考パターン |
| 参照 | `Shuffle100/SwiftUI Views/Settings/ReciteSettingsRouter.swift` | NavigationPath実装の参考パターン |

---

## フェーズ別リスク評価

| フェーズ | リスク | 理由 |
|--------|--------|------|
| Phase 0 | 極低 | 新規追加のみ |
| Phase 1 | 高 | ルート切り替え + HomeScreenのSwiftUI再現 |
| Phase 2 | 低 | Coordinatorが薄い、SwiftUIビューはほぼそのまま |
| Phase 3 | 中 | PoemPicker内部NavigationStack除去が必要 |
| Phase 4 | 最高 | 状態機械の再設計が必要 |
| Phase 5 | 低 | 主に削除作業 |

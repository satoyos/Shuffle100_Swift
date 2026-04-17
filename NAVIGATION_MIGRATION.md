# SwiftUI NavigationPath への段階的移行計画

## Context

現在のアプリはUINavigationControllerベースのCoordinatorパターンを採用している。これをSwiftUIのNavigationStackとNavigationPathに移行する。目的はUIKit依存の削減とSwiftUIネイティブなナビゲーション管理への統一。段階的に移行し、各フェーズ後にアプリが正常動作することを確認しながら進める。

## 現状の整理

### 遷移の種類
- **Push (UINavigationController)**: HomeScreen → SelectMode, SelectSinger, PoemPicker, MemorizeTimer, GameMode
- **Present (モーダル)**: ReciteSettings, HelpList, Torifuda, WhatsNext
- **NavigationPath（既存）**: HelpListView内（HelpRouter）、ReciteSettingsView内（ReciteSettingsRouter）

### Coordinator一覧（当初22個）
- **削除済み（Phase 2）**: SelectModeCoordinator, SelectSingerCoordinator, MemorizeTimerCoordinator
- **削除済み（Phase 3）**: PoemPickerCoordinator, NgramPickerCoordinator, FudaSetsCoordinator, FiveColorsCoordinator, DigitsPickerScreen01Coordinator, DigitsPickerScreen10Coordinator
- **削除済み（Phase 4）**: NormalModeCoordinator, BeginnerModeCoordinator, NonsotpModeCoordinator, HokkaidoModeCoordinator, WhatsNextCoordinator, ReciteSettingsCoordinator, TorifudaCoordinator, HelpListCoordinator, IntervalSettingCoordinator, KamiShimoIntervalSettingCoordinator, VolumeSettingCoordinator + プロトコル6つ
- **残存（Phase 5で削除予定）**: MainCoordinator, MainCoordinatorSetUpSettings, SelectModeCoordinator, SelectSingerCoordinator, MemorizeTimerCoordinator + 基盤プロトコル3つ + ActionAttachedHostingController

---

## 設計: AppRouter / AppRoute

```swift
// AppRoute.swift
enum AppRoute: Hashable {
  case selectMode
  case selectSinger
  case poemPicker
  case ngramPicker
  case fudaSets
  case fiveColors
  case digitsPicker01
  case digitsPicker10
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

**ステータス**: 完了

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

**ステータス**: 完了

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

**ステータス**: 完了

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

**ステータス**: 完了

**目標**: PoemPickerとその子画面（NgramPicker, FudaSets, FiveColors, DigitsPicker）を移行。

**実施方針**: 変更量が多いため、以下の6サブステップに分割して段階的に実施した。

### Step 3a: PoemPickerViewをAppRootViewに接続（子画面遷移なし）
- `PoemPickerView.swift`から内部`NavigationStack`を除去
- `AppRootView.swift`の`.poemPicker` destinationに`PoemPickerView`を接続
- `.searchable`のplacementを`.navigationBarDrawer(displayMode: .always)`に変更（NavigationStack除去で検索バーが消える問題を修正）

### Step 3b: NgramPickerの移行
- `AppRoute`に`.ngramPicker`を追加
- `NgramPickerView.swift`から内部`NavigationStack`を除去、`safeAreaInset`→`toolbar`に切り替え
- `PoemPickerView`に`@EnvironmentObject var router: AppRouter`を追加
- `PoemPickerToolbarButtons`の「1字目で選ぶ」を`router.push(.ngramPicker)`に変更

### Step 3c: FudaSets + FiveColorsの移行
- `AppRoute`に`.fudaSets`, `.fiveColors`を追加
- 両Viewから内部`NavigationStack`を除去、`safeAreaInset`→`toolbar`に切り替え
- `PoemPickerToolbarButtons`の該当クロージャを`router.push()`に変更

### Step 3d: DigitsPicker01 + DigitsPicker10の移行
- `AppRoute`に`.digitsPicker01`, `.digitsPicker10`を追加
- `DigitsPicker.swift`から内部`NavigationStack`を除去、`safeAreaInset`→`toolbar`に切り替え
- `PoemPickerToolbarButtons`の該当クロージャを`router.push()`に変更

### Step 3e: Torifuda（取り札）のシート表示移行
- `AppRootView`に`TorifudaSheetWrapper`を追加（NavigationStack + タイトル + 閉じるボタン）
- `PoemPickerView`の`showTorifudaAction`を`router.presentSheet(.torifuda(poem))`に変更

### Step 3f: 旧Coordinator削除とクリーンアップ
- `PoemPickerView`から不要なクロージャプロパティをすべて削除
- `saveSetAction`を`router.saveSettings()`に置換
- 以下のCoordinatorファイルを削除（6個）:
  - `PoemPickerCoordinator.swift`
  - `NgramPickerCoordinator.swift`
  - `FudaSetsCoordinator.swift`
  - `FiveColorsCoordinator.swift`
  - `DigitsPickerScreen01Coordinator.swift`
  - `DigitsPickerScreen10Coordinatorswift.swift`
- `MainCoordinator.swift`の`selectPoem`メソッドからPoemPickerCoordinator参照を除去
- `NavigationBarTests`を更新（UINavigationBarのglobal appearance設定はSwiftUI移行で不要になったため）

**注記**: `TorifudaCoordinator`は`WhatsNextCoordinator`から参照されているためPhase 4で対処する。

**テスト確認**: 全304ユニットテスト通過

---

## Phase 4: ゲームモード画面の移行（最難関）

**ステータス**: 完了

**目標**: RecitePoemBaseView + 4つのゲームモード、WhatsNextViewを移行。

**アーキテクチャ**:
旧 Coordinator のクロージャ動的入れ替え方式を、明示的な `GamePhase` enum + Strategy パターンの `GameStateManager` に置き換えた。

### Step 4a: 基盤型の定義
**新規ファイル (6)**:
- `Shuffle100/Navigation/GamePhase.swift` — `.joka`, `.kami`, `.waitingForShimo`, `.shimo`, `.shimoRefrainBeforeAdvance`, `.whatsNext`, `.gameEnd`
- `Shuffle100/Navigation/GameStrategy.swift` — `hasKami`, `autoAdvanceFromKami`, `showsWhatsNext`, `forcesShortenedJoka` 等のプロトコル
- `Shuffle100/Navigation/GameStrategies/NormalGameStrategy.swift`
- `Shuffle100/Navigation/GameStrategies/BeginnerGameStrategy.swift`
- `Shuffle100/Navigation/GameStrategies/NonstopGameStrategy.swift`
- `Shuffle100/Navigation/GameStrategies/HokkaidoGameStrategy.swift`

### Step 4b: GameStateManager の実装
**新規ファイル**: `Shuffle100/Navigation/GameStateManager.swift`
- BaseViewModel のクロージャを init 時に1回だけ固定し、`handlePlayerFinished()` 等で `switch phase` により状態遷移
- コールバック: `onPresentWhatsNext`, `onBackToHome`, `onOpenSettings`
- WhatsNext 操作: `handleGoNext()`, `handleRefrainShimo()`, `handleExitGame()`, `startPostMortem()`

**新規テスト**: `Shuffle100Tests/Navigation/GameStateManagerTests.swift` (28件)

### Step 4c: WhatsNextSheetWrapper の実装
- `AppRootView.swift` に `WhatsNextSheetWrapper` 追加
- `AppRouter.swift` に `var gameStateManager: GameStateManager?` 追加

### Step 4d: GamePlayView の実装と切り替え
**新規ファイル**: `Shuffle100/SwiftUI Views/GameFlow/GamePlayView.swift`
- `AppRootView.swift` の `.normalMode`, `.beginnerMode`, `.nonstopMode`, `.hokkaidoMode` destination を実装

### Step 4e: 統合テスト・バグ修正
- 感想戦・rewind・北海道読み返し・isIdleTimerDisabled を検証
- **北海道モード rewind バグ修正**: `handleRewind()` で `strategy.hasKami` 分岐を追加
- **バッジ表示バグ修正**: PoemPicker 配下の「まとめて選ぶ」4画面で、戻った時にバッジが古い値を表示する問題を修正。各 ViewModel に `convenience init(settings:)` を追加し、`output.$state100.dropFirst().sink` で settings への即時書き戻しを実装
  - 修正: `NgramPickerViewModel`, `FiveColorsViewModel`, `FudaSetsView.ViewModel`, `DigitsPickerViewModel` + 対応する View 4つ
  - 回帰テスト 5件追加

### Step 4f: テスト移行
旧 Coordinator テスト3ファイルを調査し、未カバーの4シナリオを `GameStateManagerTests.swift` に追記:
1. Normal: 連続 rewind でホームに戻らない
2. Beginner: rewind 後の下の句完了で WhatsNext 再表示
3. Hokkaido: rewind 後の下の句完了で WhatsNext 再表示
4. Hokkaido: 1首目 rewind → ホームに戻る

### Step 4g: 旧 Coordinator 削除
**削除ファイル (20)**:
- ゲームモード Coordinator 5: `NormalModeCoordinator`, `BeginnerModeCoordinator`, `NonsotpModeCoordinator`, `HokkaidoModeCoordinator`, `WhatsNextCoordinator`
- 設定系 Coordinator 6: `ReciteSettingsCoordinator`, `TorifudaCoordinator`, `HelpListCoordinator`, `IntervalSettingCoordinator`, `KamiShimoIntervalSettingCoordinator`, `VolumeSettingCoordinator`
- プロトコル 6: `RecitePoemCore`, `PoemRecitation`, `KamiShimoRecitation`, `WhatsNextSupport`, `RecitePoemViewModelHolder`, `BackToHomeProtocol`
- テスト 3: `NormalModeCoordinatorTest`, `BeginnerModeCoordinatorTest`, `HokkaidoModeCoordinatorTest`
- `MainCoordinator.swift` の `startGame()`, `openReciteSettings()`, `openHelpList()` の中身を除去
- `HelpListScreenTest.swift` の `HelpListCoordinator` 依存テスト除去

**テスト確認**: 全344ユニットテスト通過

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

**削除ファイル**（Phase 4完了後の残存分）:
- `coordinaters/MainCoordinator.swift`
- `coordinaters/MainCoordinatorSetUpSettings.swift`
- `coordinaters/SelectModeCoordinator.swift`
- `coordinaters/SelectSingerCoordinator.swift`
- `coordinaters/MemorizeTimerCoordinator.swift`
- `coordinaters/protocols/CoordinatorProtocol.swift`
- `coordinaters/protocols/HandleNavigatorProtocol.swift`
- `coordinaters/protocols/SaveSettingsProtocol.swift`
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

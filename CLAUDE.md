# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## プロジェクト概要

Shuffle100は、百人一首かるたの読み上げを行うiOSアプリです。競技かるたの練習や対戦時に、人の代わりに歌を読み上げる機能を提供します。

### 主な機能
- ボーカロイド音声（IA）または人間音声（いなばくん）による読み上げ
- 通常モード（競技かるた）、初心者モード（散らし取り）、ノンストップモード、北海道モード
- 歌の選択と札セットの保存機能
- 空札（からふだ）設定
- 記憶タイマー機能

## 開発環境とビルド

### 必要な環境
- Xcode 15.0以上
- iOS 16.0以上対応
- Swift 5.0以上
- CocoaPods

### ビルドコマンド
```bash
# 依存関係のインストール
pod install

# Xcodeでプロジェクトを開く（必須：.xcworkspaceを使用）
open Shuffle100.xcworkspace
```

### テスト実行
```bash
# 単体テスト（Shuffle100Testsターゲットのみ）
xcodebuild test -workspace Shuffle100.xcworkspace -scheme Shuffle100 -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing Shuffle100Tests

# UIテスト
xcodebuild test -workspace Shuffle100.xcworkspace -scheme Shuffle100UITests -destination 'platform=iOS Simulator,name=iPhone 16'
```

### Fastlane（将来の拡張用）
- `fastlane/Fastfile` は基本設定のみ
- スクリーンショット撮影用の設定が `Snapfile` に含まれる

## アーキテクチャ

### 全体構成
プロジェクトはCoordinatorパターンを採用したUIKit+SwiftUIハイブリッドアーキテクチャです。

```
App
├── Models/ - データモデルとビジネスロジック
├── Coordinators/ - 画面遷移とナビゲーション制御  
├── Screens/ - UIKitベースの画面
├── SwiftUI Views/ - SwiftUIベースのビューとViewModel
├── Views/ - 共通UIコンポーネント
├── AudioPlayers/ - 音声再生システム
└── Resources/ - 音声ファイルとJSONデータ
```

### Coordinatorパターン
- `MainCoordinator`: アプリ全体の遷移を管理
- 各画面専用のCoordinator（`PoemPickerCoordinator`, `ReciteSettingsCoordinator`など）
- プロトコル `CoordinatorProtocol` で統一されたインターフェース

### 主要コンポーネント

#### Models
- `Poem`: 百人一首の歌データ（上の句、下の句、歌人情報など）
- `Settings`: アプリ設定（読み上げモード、選択した歌、音声設定など）
- `StoreManager`: UserDefaultsベースの永続化
- `AudioPlayerFactory`: 音声再生の統一インターフェース

#### 音声システム
- `AudioPlayerFactory`: シングルトンで音声セッション管理
- 音声ファイルは `/resources/audio/ia/` (ボーカロイド) と `/resources/audio/inaba/` (人間音声) に配置
- AVAudioPlayerを使用したバックグラウンド再生対応

#### SwiftUI統合
- UIKitをベースとしつつ、一部画面でSwiftUIを採用
- `ActionAttachedHostingController` でUIKitとSwiftUIを連携
- ViewModelパターンで状態管理（`Torifuda.ViewModel`, `FullLiner.ViewModel`など）

## 開発時の注意点

### 依存関係
- **SnapKit**: Auto Layout制約の簡潔な記述
- **FontAwesome.swift**: アイコンフォント
- **Then**: オブジェクト初期化の簡潔化

### コーディング規約
- **インデント**: 半角スペースを使用（タブは使用しない）
- **インデント幅**: 2スペース
- 既存のSwiftファイルと一貫性を保つため

### テスト構成
- `Shuffle100Tests/`: 単体テスト（Models, Coordinators, Viewsをカバー）
- `Shuffle100UITests/`: UIテスト（画面遷移とユーザーインタラクションをテスト）
- `fastlane/screenshots/`: 自動スクリーンショット撮影結果

### 音声ファイルの取り扱い
- `resources/audio/ia/`: ボーカロイド音声（MITライセンス）
- `resources/audio/inaba/`: 人間音声（リポジトリに含まれず - 開発者が個別に入手・配置）

**重要**: 本リポジトリには、著作権その他の権利により再配布が許可されていない音声ファイル（例：`resources/audio/inaba/`）は含まれていません。これらのファイルは開発者各自で入手し、ローカル環境の所定のディレクトリに配置してください。

#### inaba音声ファイルの詳細仕様

**配置先**: `Shuffle100/resources/audio/inaba/`

**ファイル構成（201個）**:
```
序歌.m4a                    # 序歌（1個）
001a.m4a ～ 100a.m4a        # 上の句（100個）
001b.m4a ～ 100b.m4a        # 下の句（100個）
```

**ファイル形式**: M4A (AAC)

**最小構成** (アプリ動作確認用):
- `序歌.m4a`
- `001a.m4a` 
- `001b.m4a`

**エラーハンドリング**: 
- `Singer.hasRequiredAudioFiles()` で最小構成の存在を確認
- ファイルが不足している場合、ユーザーにアラート表示後、デフォルト（IA）に自動切替
- `AudioPlayerFactory` は音声ファイルが見つからない場合、`nil` を返すよう設計

### 主要なデータファイル
- `resources/100.json`: 百人一首の全歌データ
- `resources/Singers.json`: 読み手情報
- `resources/ngram.json`: かな文字のN-gramデータ

## よく使用するコマンド

```bash
# Podsの更新
pod update

# キャッシュクリア
rm -rf ~/Library/Developer/Xcode/DerivedData/Shuffle100-*

# シミュレータのリセット
xcrun simctl erase all
```
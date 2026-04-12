//
//  GamePlayView.swift
//  Shuffle100
//
//  各ゲームモードの読み上げ画面。
//  GameStateManager を @StateObject で保持し、RecitePoemBaseView を表示する。
//  序歌の再生開始はナビゲーション遷移アニメーションが完了してから行いたいため、
//  onAppear 内で短い遅延 (旧 CATransaction.setCompletionBlock の代替) の後に開始する。
//

import SwiftUI

struct GamePlayView: View {
  @EnvironmentObject private var router: AppRouter
  @StateObject var gameStateManager: GameStateManager

  var body: some View {
    RecitePoemBaseView(
      settings: gameStateManager.settings,
      viewModel: gameStateManager.baseViewModel
    )
    .onAppear {
      // AppRouter に gameStateManager を登録 (WhatsNext シート等からの参照用)
      router.gameStateManager = gameStateManager

      // コールバック接続
      gameStateManager.onPresentWhatsNext = { [weak router] poem in
        router?.presentSheet(.whatsNext(poem))
      }
      gameStateManager.onBackToHome = { [weak router] in
        router?.popToRoot()
      }
      gameStateManager.onOpenSettings = { [weak router] in
        router?.presentSheet(.reciteSettings)
      }

      // ナビゲーション遷移アニメーション完了を待ってから序歌を開始
      // (旧 CATransaction.setCompletionBlock の代替)
      Task {
        try? await Task.sleep(for: .milliseconds(400))
        gameStateManager.startGame()
      }
    }
    .onDisappear {
      router.gameStateManager = nil
    }
  }
}

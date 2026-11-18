//
//  RecitePoemModifiers.swift
//  Shuffle100
//
//  Created by Claude Code on 2025/12/29.
//

import SwiftUI

// MARK: - Dialogs
extension RecitePoemBaseView {

  // MARK: - Exit Alert

  var exitAlert: some View {
    EmptyView()
      .alert("試合を終了しますか？", isPresented: $showExitAlert) {
        Button("終了する", role: .destructive) {
          viewModel.recitePoemViewModel.backToHomeScreenAction?()
        }
        Button("続ける", role: .cancel) {}
      }
  }

  // MARK: - Post Mortem Dialog

  var postMortemDialog: some View {
    EmptyView()
      .confirmationDialog(
        "感想戦を始めますか？",
        isPresented: $showPostMortemDialog,
        titleVisibility: .visible
      ) {
        Button("感想戦を始める") {
          viewModel.recitePoemViewModel.startPostMortemAction?()
        }
        Button("トップに戻る") {
          viewModel.recitePoemViewModel.backToHomeScreenAction?()
        }
        Button("キャンセル", role: .cancel) {}
      } message: {
        Text("今の試合と同じ順番に詩を読み上げる「感想戦」を始めることができます。")
      }
  }
}

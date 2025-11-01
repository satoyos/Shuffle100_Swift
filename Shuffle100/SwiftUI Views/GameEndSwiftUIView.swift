//
//  GameEndSwiftUIView.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/10/13.
//

import SwiftUI

// MARK: - Simple Game End View

struct SimpleGameEndSwiftUIView: View {
  let title: String
  let backToHomeAction: () -> Void

  var body: some View {
    VStack(spacing: 0) {
      // Header
      ZStack {
        Color(StandardColor.barTintColor)
        Text(title)
          .foregroundColor(.primary)
          .font(.body)
      }
      .frame(height: 40)

      // Main content
      ZStack {
        Color(.systemBackground)

        Button(action: backToHomeAction) {
          Text("トップに戻る")
            .foregroundColor(Color(StandardColor.standardButtonColor))
        }
      }
    }
  }
}

// MARK: - Post Mortem Enabled Game End View

struct PostMortemEnabledGameEndSwiftUIView: View {
  let title: String
  @StateObject private var viewModel: PostMortemEnabledGameEndViewModel

  init(title: String,
       backToHomeAction: @escaping () -> Void,
       startPostMortemAction: @escaping () -> Void) {
    self.title = title
    self._viewModel = StateObject(wrappedValue: PostMortemEnabledGameEndViewModel(
      backToHomeAction: backToHomeAction,
      startPostMortemAction: startPostMortemAction
    ))
  }

  var body: some View {
    VStack(spacing: 0) {
      // Header
      ZStack {
        Color(StandardColor.barTintColor)
        Text(title)
          .foregroundColor(.primary)
          .font(.body)
      }
      .frame(height: 40)

      // Main content
      ZStack {
        Color(.systemBackground)

        VStack(spacing: 60) {
          Button(action: viewModel.backToHomeAction) {
            Text("トップに戻る")
              .foregroundColor(Color(StandardColor.standardButtonColor))
          }

          Button(action: viewModel.requestPostMortem) {
            Text("感想戦を始める")
              .foregroundColor(Color(StandardColor.standardButtonColor))
          }
        }
      }
    }
    .alert("感想戦を始めますか？", isPresented: $viewModel.showPostMortemConfirmation) {
      Button("始める", action: viewModel.startPostMortemAction)
      Button("キャンセル", role: .cancel) {}
    } message: {
      Text("今の試合と同じ歌を同じ順序で読み上げます")
    }
  }
}

// MARK: - Previews

#Preview("Simple Game End") {
  SimpleGameEndSwiftUIView(
    title: "試合終了",
    backToHomeAction: {}
  )
}

#Preview("Post Mortem Enabled Game End") {
  PostMortemEnabledGameEndSwiftUIView(
    title: "試合終了",
    backToHomeAction: {},
    startPostMortemAction: {}
  )
}

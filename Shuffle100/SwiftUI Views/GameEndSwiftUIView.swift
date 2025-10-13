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
  let backToHomeAction: () -> Void
  let gotoPostMortemAction: () -> Void

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
          Button(action: backToHomeAction) {
            Text("トップに戻る")
              .foregroundColor(Color(StandardColor.standardButtonColor))
          }

          Button(action: gotoPostMortemAction) {
            Text("感想戦を始める")
              .foregroundColor(Color(StandardColor.standardButtonColor))
          }
        }
      }
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
    gotoPostMortemAction: {}
  )
}

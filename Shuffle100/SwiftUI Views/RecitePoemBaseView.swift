//
//  RecitePoemBaseView.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/09/24.
//

import SwiftUI

struct RecitePoemBaseView {
  let settings: Settings
  @ObservedObject private var viewModel: RecitePoemBaseViewModel

  init(settings: Settings, viewModel: RecitePoemBaseViewModel) {
    self.settings = settings
    self.viewModel = viewModel
  }
}

extension RecitePoemBaseView: View {
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        // Safe Area外の背景色を上下で分ける
        GeometryReader { geo in
          VStack(spacing: 0) {
            // 上側: Header色
            Color(StandardColor.barTintColor)
              .frame(height: geo.safeAreaInsets.top)

            Spacer()

            Color(.systemBackground)
              .frame(height: geo.safeAreaInsets.bottom)
          }
          .ignoresSafeArea()
          .onAppear {
            // 画面サイズをViewModelに設定
            viewModel.screenWidth = geometry.size.width
          }
        }

        Color(.systemBackground)

        // フリップアニメーション用の2面構造
        // 最適化: 見えている面のみをレンダリング
        ZStack {
          if viewModel.isFrontVisible {
            // 表面のみレンダリング (0〜180度)
            frontSideView()
              .frame(width: geometry.size.width, height: geometry.size.height)
          } else {
            // 裏面のみレンダリング (180〜360度)
            backSideView()
              .frame(width: geometry.size.width, height: geometry.size.height)
              .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
          }
        }
        .rotation3DEffect(
          .degrees(viewModel.output.rotationAngle),
          axis: (x: 0, y: 1, z: 0)
        )
        .animation(.spring(response: Double(settings.interval), dampingFraction: 1.0), value: viewModel.output.rotationAngle)

        // スライドインするビュー
        if viewModel.output.showingSlideCard {
          RecitePoemSwiftUIView(
            settings: settings,
            viewModel: viewModel.recitePoemViewModel
          )
          .frame(width: geometry.size.width, height: geometry.size.height)
          .offset(x: viewModel.output.slideOffset)
        }
      }
    }
    .navigationBarHidden(true)
  }

  // MARK: - Helper Views

  @ViewBuilder
  private func frontSideView() -> some View {
    if viewModel.output.showGameEndView {
      // ゲーム終了画面 - フリップアニメーション中も常に表示
      gameEndView()
    } else {
      // 通常のRecitePoemView
      RecitePoemSwiftUIView(
        settings: settings,
        viewModel: viewModel.recitePoemViewModel
      )
    }
  }

  @ViewBuilder
  private func backSideView() -> some View {
    if viewModel.output.showGameEndView {
      // ゲーム終了画面
      gameEndView()
    } else {
      // 通常のRecitePoemView
      RecitePoemSwiftUIView(
        settings: settings,
        viewModel: viewModel.recitePoemViewModel
      )
    }
  }

  @ViewBuilder
  private func gameEndView() -> some View {
    if settings.postMortemEnabled {
      PostMortemEnabledGameEndSwiftUIView(
        title: "試合終了",
        backToHomeAction: {
          viewModel.recitePoemViewModel.backToHomeScreenAction?()
        },
        startPostMortemAction: {
          viewModel.recitePoemViewModel.startPostMortemAction?()
        }
      )
    } else {
      SimpleGameEndSwiftUIView(
        title: "試合終了",
        backToHomeAction: {
          viewModel.recitePoemViewModel.backToHomeScreenAction?()
        }
      )
    }
  }
}

#Preview {
  RecitePoemBaseView(
    settings: Settings(),
    viewModel: RecitePoemBaseViewModel(settings: Settings())
  )
}

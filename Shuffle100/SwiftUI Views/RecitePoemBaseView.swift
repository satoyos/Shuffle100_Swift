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
        Color(.systemBackground)
          .ignoresSafeArea()
          .onAppear {
            // 画面サイズをViewModelに設定
            viewModel.screenWidth = geometry.size.width
          }

        // フリップアニメーション用の2面構造
        ZStack {
          // 表面（0〜180度で表示）
          RecitePoemSwiftUIView(
            settings: settings,
            viewModel: viewModel.recitePoemViewModel
          )
          .frame(width: geometry.size.width, height: geometry.size.height)
          .opacity(viewModel.isFrontVisible ? 1 : 0)
          .allowsHitTesting(viewModel.isFrontVisible)

          // 裏面（180〜360度で表示）
          RecitePoemSwiftUIView(
            settings: settings,
            viewModel: viewModel.recitePoemViewModel
          )
          .frame(width: geometry.size.width, height: geometry.size.height)
          .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
          .opacity(viewModel.isFrontVisible ? 0 : 1)
          .allowsHitTesting(!viewModel.isFrontVisible)
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
}

#Preview {
  RecitePoemBaseView(
    settings: Settings(),
    viewModel: RecitePoemBaseViewModel(settings: Settings())
  )
}

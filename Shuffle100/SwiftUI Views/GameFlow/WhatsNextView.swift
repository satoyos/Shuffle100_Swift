//
//  WhatsNextView.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/10/19.
//

import SwiftUI

struct WhatsNextView {
  @ObservedObject private var viewModel: WhatsNextViewModel
  @Environment(\.isPresented) private var isPresented
  @Environment(\.dismiss) private var dismiss

  init(currentPoem: Poem) {
    self.viewModel = WhatsNextViewModel(currentPoem: currentPoem)
  }

  // ViewModelのアクションを外部から設定できるようにする
  func setActions(
    showTorifuda: @escaping () -> Void,
    refrain: @escaping () -> Void,
    goNext: @escaping () -> Void,
    goSetting: @escaping () -> Void,
    backToHome: @escaping () -> Void
  ) {
    viewModel.showTorifudaAction = showTorifuda
    viewModel.refrainAction = refrain
    viewModel.goNextAction = goNext
    viewModel.goSettingAction = goSetting
    viewModel.backToHomeScreenAction = backToHome
  }
}

extension WhatsNextView: View {
  var body: some View {
    GeometryReader { geometry in
      let buttonHeight = calculateButtonHeight(geometry: geometry)
      let buttonSpacing = geometry.size.height * 0.12

      ZStack {
        Color(uiColor: StandardColor.backgroundColor)
          .ignoresSafeArea()

        VStack {
          Spacer()

          LazyVGrid(columns: [GridItem(.flexible())], spacing: buttonSpacing) {
            WhatsNextButton(
              imageName: "torifuda",
              title: "取り札を見る",
              buttonHeight: buttonHeight,
              action: {
                viewModel.input.torifudaButtonTapped.send()
              }
            )
            .accessibilityLabel("torifuda")

            WhatsNextButton(
              imageName: "refrain",
              title: "下の句をもう一度読む",
              buttonHeight: buttonHeight,
              action: {
                viewModel.input.refrainButtonTapped.send()
                dismiss()
              }
            )
            .accessibilityLabel("refrain")

            WhatsNextButton(
              imageName: "go_next",
              title: "次の歌へ！",
              buttonHeight: buttonHeight,
              action: {
                viewModel.input.goNextButtonTapped.send()
                dismiss()
              }
            )
            .accessibilityLabel("goNext")
          }
          .padding(.horizontal)

          Spacer()
        }
      }
    }
    .navigationTitle("次はどうする？")
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Button(action: {
          viewModel.input.gearButtonTapped.send()
        }) {
          Image("gear-520")
            .resizable()
            .renderingMode(.template)
            .frame(width: navBarButtonSize, height: navBarButtonSize)
        }
        .accessibilityLabel("gear")
      }

      ToolbarItem(placement: .navigationBarTrailing) {
        Button(action: {
          viewModel.input.exitButtonTapped.send()
        }) {
          Image("exit_square")
            .resizable()
            .renderingMode(.template)
            .frame(width: navBarButtonSize, height: navBarButtonSize)
        }
        .accessibilityLabel("exit")
      }
    }
    .alert("試合を終了しますか？", isPresented: viewModel.$binding.showExitConfirmation) {
      Button("終了する", role: .destructive) {
        dismiss()
        viewModel.backToHomeScreenAction?()
      }
      Button("続ける", role: .cancel) {}
    }
    .onAppear {
      // 自動的にスリープに入るのを防ぐ
      UIApplication.shared.isIdleTimerDisabled = true
    }
    .onDisappear {
      // スリープを有効に戻す
      UIApplication.shared.isIdleTimerDisabled = false
    }
  }

  private func calculateButtonHeight(geometry: GeometryProxy) -> CGFloat {
    min(geometry.size.height * 0.15, geometry.size.width * 0.12)
  }

  private var navBarButtonSize: CGFloat {
    32
  }
}

#Preview {
  NavigationStack {
    WhatsNextView(currentPoem: PoemSupplier.originalPoems[0])
  }
}

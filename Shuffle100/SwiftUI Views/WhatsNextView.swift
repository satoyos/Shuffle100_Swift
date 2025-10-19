//
//  WhatsNextView.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/10/19.
//

import SwiftUI

struct WhatsNextView {
  @ObservedObject private var viewModel: WhatsNextViewModel
  @EnvironmentObject var screenSizeStore: ScreenSizeStore
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
      ZStack {
        Color(uiColor: StandardColor.backgroundColor)
          .ignoresSafeArea()

        VStack(spacing: 0) {
          // 取り札を見るボタン (20%の位置)
          Spacer()
            .frame(height: geometry.size.height * 0.2 - buttonHeight / 2)

          WhatsNextButton(
            imageName: "torifuda",
            title: "取り札を見る",
            action: {
              viewModel.input.torifudaButtonTapped.send()
            }
          )
          .accessibilityLabel("torifuda")

          // 下の句をもう一度読むボタン (40%の位置)
          Spacer()
            .frame(height: geometry.size.height * 0.2)

          WhatsNextButton(
            imageName: "refrain",
            title: "下の句をもう一度読む",
            action: {
              viewModel.input.refrainButtonTapped.send()
              dismiss()
            }
          )
          .accessibilityLabel("refrain")

          // 次の歌へボタン (60%の位置)
          Spacer()
            .frame(height: geometry.size.height * 0.2)

          WhatsNextButton(
            imageName: "go_next",
            title: "次の歌へ！",
            action: {
              viewModel.input.goNextButtonTapped.send()
              dismiss()
            }
          )
          .accessibilityLabel("goNext")

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
      Button("終了する", role: .cancel) {
        dismiss()
        viewModel.backToHomeScreenAction?()
      }
      Button("続ける", role: .none) {}
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

  private var buttonHeight: CGFloat {
    let sizes = SizeFactory.createSizeByDevice()
    return sizes.whatsNextButtonHeight
  }

  private var navBarButtonSize: CGFloat {
    32
  }
}

#Preview {
  NavigationStack {
    WhatsNextView(currentPoem: PoemSupplier.originalPoems[0])
    .environmentObject(ScreenSizeStore())
  }
}

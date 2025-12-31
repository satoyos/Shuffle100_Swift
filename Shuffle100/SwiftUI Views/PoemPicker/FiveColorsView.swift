//
//  FiveColorsView.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/04/01.
//

import SwiftUI

struct FiveColorsView {
  let settings: Settings
  @State private var showActionSheet = false
  @State private var selectedColor: FiveColors = .blue
  @ObservedObject private var viewModel: FiveColorsViewModel
  @EnvironmentObject var screenSizeStore: ScreenSizeStore
  @Environment(\.isPresented) private var isPresented
  
  init(settings: Settings) {
    self.settings = settings
    self.viewModel = .init(state100: settings.state100)
  }
}

extension FiveColorsView: View {
  var body: some View {
    NavigationStack {
      Spacer()
      List {
        ForEach(FiveColors.all) { color in
          FiveColorButton(viewModel: color.buttonViewModel) {
            showActionSheet = true
            selectedColor = color
          }
          .actionSheet(isPresented: $showActionSheet,
                       content: fiveColorsActionSheet)
        }
      }
      //
      // 本当は、以下のように toolbarを使って実装したい。
      //
//      .toolbar {
//        ToolbarItem(placement: .confirmationAction) {
//          BadgeView(number: viewModel.output.state100.selectedNum)
//        }
//        ToolbarItem(placement: .principal) {
//          Text("五色百人一首")
//        }
//      }
      //
      // ただ、Shuffle100がまだUIKitからこのViewを呼び出しているので、
      //  表示の整合性のために、次のように saveAreaInsetを使う
      //
      .safeAreaInset(edge: .top) {
        HStack {
          Spacer()
          BadgeView(number: viewModel.output.state100.selectedNum)
            .padding()
        }
        .frame(height: 30)
      }
    }
    .onChange(of: isPresented) {
      guard !isPresented else { return }
      tasksForLeavingThisVIew()
    }
  }
  
  private func fiveColorsActionSheet() -> ActionSheet {
    ActionSheet(
      title: Text("\(selectedColor.description)色の20首をどうしますか？"),
      message: nil,
      buttons: [
        .default(Text("この20首だけを選ぶ")) {
          viewModel.input.selectJust20OfColor.send(selectedColor)
        },
        .default(Text("今選んでいる札に加える")) {
          viewModel.input.add20OfColor.send(selectedColor)
        },
        .cancel()
      ]
    )
  }
  
  func tasksForLeavingThisVIew() {
    settings.state100 = viewModel.output.state100
  }
  
}

#Preview {
  FiveColorsView(settings: Settings())
    .environmentObject(ScreenSizeStore())
}

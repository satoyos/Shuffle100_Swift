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

  init(settings: Settings) {
    self.settings = settings
    self.viewModel = .init(settings: settings)
  }
}

extension FiveColorsView: View {
  var body: some View {
    GeometryReader { geometry in
      List {
        ForEach(FiveColors.all) { color in
          FiveColorButton(
            viewModel: color.buttonViewModel,
            containerHeight: geometry.size.height) {
            showActionSheet = true
            selectedColor = color
          }
          .actionSheet(isPresented: $showActionSheet,
                       content: fiveColorsActionSheet)
        }
      }
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          BadgeView(number: viewModel.output.state100.selectedNum)
        }
      }
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
}

#Preview {
  FiveColorsView(settings: Settings())
}

//
//  PoemPickerToolbarButtons.swift
//  Shuffle100
//
//  Copyright © 2025 里 佳史. All rights reserved.
//

import SwiftUI

// MARK: - Toolbar Buttons
extension PoemPickerView {

  var cancelAllButton: some View {
    Button("全て取消") {
      viewModel.input.cancelAll.send()
    }
    .lineLimit(1)
    .minimumScaleFactor(0.7)
  }

  var selectAllButton: some View {
    Button("全て選択") {
      viewModel.input.selectAll.send()
    }
    .lineLimit(1)
    .minimumScaleFactor(0.7)
  }

  var selectByGroupButton: some View {
    Button("まとめて選ぶ") {
      viewModel.binding.showActionSheet = true
    }
    .lineLimit(1)
    .minimumScaleFactor(0.7)
    .actionSheet(isPresented: $viewModel.binding.showActionSheet) {
      ActionSheet(
        title: Text("どうやって選びますか？"),
        buttons: actionSheetButtons
      )
    }
  }

  private var actionSheetButtons: [ActionSheet.Button] {
    var buttons: [ActionSheet.Button] = []

    // UIKit版と同じ順序で追加
    if !settings.savedFudaSets.isEmpty {
      buttons.append(
        .default(Text("作った札セットから選ぶ")) {
          router.push(.fudaSets)
        }
      )
    }

    buttons.append(
      .default(Text("1字目で選ぶ")) {
        router.push(.ngramPicker)
      }
    )

    buttons.append(
      .default(Text("五色百人一首の色で選ぶ")) {
        router.push(.fiveColors)
      }
    )

    buttons.append(
      .default(Text("1の位の数で選ぶ")) {
        router.push(.digitsPicker01)
      }
    )

    buttons.append(
      .default(Text("10の位の数で選ぶ")) {
        router.push(.digitsPicker10)
      }
    )

    buttons.append(.cancel(Text("キャンセル")))

    return buttons
  }
}
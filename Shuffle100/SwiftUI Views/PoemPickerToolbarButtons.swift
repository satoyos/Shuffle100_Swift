//
//  PoemPickerToolbarButtons.swift
//  Shuffle100
//
//  Created by Claude Code on 2025/09/05.
//  Copyright © 2025 里 佳史. All rights reserved.
//

import SwiftUI

// MARK: - Toolbar Buttons
extension PoemPickerView {
  
  var cancelAllButton: some View {
    Button("全て取消") {
      viewModel.input.cancelAll.send()
    }
  }

  var selectAllButton: some View {
    Button("全て選択") {
      viewModel.input.selectAll.send()
    }
  }

  var selectByGroupButton: some View {
    Button("まとめて選ぶ") {
      viewModel.binding.showActionSheet = true
    }
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
          openFudaSetsScreenAction?()
        }
      )
    }

    buttons.append(
      .default(Text("1字目で選ぶ")) {
        openNgramPickerAction?()
      }
    )

    buttons.append(
      .default(Text("五色百人一首の色で選ぶ")) {
        openFiveColorsScreenAction?()
      }
    )

    buttons.append(
      .default(Text("1の位の数で選ぶ")) {
        openDigitsPicker01Action?()
      }
    )

    buttons.append(
      .default(Text("10の位の数で選ぶ")) {
        openDigitsPicker10Action?()
      }
    )

    buttons.append(.cancel(Text("キャンセル")))

    return buttons
  }
}
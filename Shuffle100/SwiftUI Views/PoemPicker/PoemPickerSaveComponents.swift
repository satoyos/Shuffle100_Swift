//
//  PoemPickerSaveComponents.swift
//  Shuffle100
//
//  Copyright © 2025 里 佳史. All rights reserved.
//

import SwiftUI

// MARK: - Save Components
extension PoemPickerView {

  var saveButton: some View {
    Button("保存") {
      viewModel.input.saveSet.send()
    }
    .actionSheet(isPresented: $viewModel.binding.showSaveActionSheet) {
      saveActionSheet
    }
    .alert(viewModel.binding.successAlertTitle, isPresented: $viewModel.binding.showSuccessAlert, actions: {
      Button("OK") { }
    }, message: {
      Text(viewModel.output.successMessage)
    })
    .alert("歌を選びましょう", isPresented: $viewModel.binding.showEmptySetAlert) {
      Button("戻る") { }
    } message: {
      Text("空の札セットは保存できません。")
    }
    .alert("新しい札セットの名前", isPresented: $viewModel.binding.showNewSetNameAlert, actions: {
      newSetNameAlert
    })
    .alert("新しい札セットの名前を決めましょう", isPresented: $viewModel.binding.showNoNameGivenAlert) {
      Button("戻る") {
        viewModel.binding.showNewSetNameAlert = true
      }
    }
    .confirmationDialog(
      "上書きする札セットを選ぶ",
      isPresented: $viewModel.binding.showOverwritePickerAlert,
      titleVisibility: .visible
    ) {
      ForEach(0..<viewModel.output.availableOverwriteSets.count, id: \.self) { index in
        let fudaSet = viewModel.output.availableOverwriteSets[index]
        Button("\(fudaSet.name) (\(fudaSet.state100.selectedNum)首)") {
          viewModel.binding.selectedOverwriteIndex = index
          viewModel.overwriteExistingFudaSet()
          saveSetAction?()
        }
      }

      Button("キャンセル", role: .cancel) { }
    }
  }

  private var saveActionSheet: ActionSheet {
    var buttons: [ActionSheet.Button] = []

    buttons.append(
      .default(Text("新しい札セットとして保存する")) {
        viewModel.prepareNewSetCreation()
      }
    )

    if !viewModel.output.availableOverwriteSets.isEmpty {
      buttons.append(
        .default(Text("前に作った札セットを上書きする")) {
          viewModel.prepareOverwriteSelection()
        }
      )
    }

    buttons.append(.cancel(Text("キャンセル")))

    return ActionSheet(
      title: Text("選んでいる札をどのように保存しますか？"),
      buttons: buttons
    )
  }

  private var newSetNameAlert: some View {
    VStack {
      TextField("札セットの名前", text: $viewModel.binding.newSetName)

      HStack {
        Button("キャンセル") {
          viewModel.binding.newSetName = ""
        }

        Button("決定") {
          viewModel.saveNewFudaSet()
          saveSetAction?()
        }
      }
    }
  }
}
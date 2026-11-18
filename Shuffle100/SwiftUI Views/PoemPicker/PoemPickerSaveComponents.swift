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
      switch viewModel.prepareSave() {
      case .showActionSheet:
        showSaveActionSheet = true
      case .showEmptySetAlert:
        showEmptySetAlert = true
      }
    }
  }

  var savePresentationAnchor: some View {
    Color.clear
      .frame(width: 0, height: 0)
      .actionSheet(isPresented: $showSaveActionSheet) {
        saveActionSheet
      }
      .alert(saveResult?.alertTitle ?? "", isPresented: $showSuccessAlert, actions: {
        Button("OK") { }
      }, message: {
        Text(saveResult?.successMessage ?? "")
      })
      .alert("歌を選びましょう", isPresented: $showEmptySetAlert) {
        Button("戻る") { }
      } message: {
        Text("空の札セットは保存できません。")
      }
      .alert("新しい札セットの名前", isPresented: $showNewSetNameAlert, actions: {
        newSetNameAlert
      })
      .alert("新しい札セットの名前を決めましょう", isPresented: $showNoNameGivenAlert) {
        Button("戻る") {
          showNewSetNameAlert = true
        }
      }
      .confirmationDialog(
        "上書きする札セットを選ぶ",
        isPresented: $showOverwritePickerAlert,
        titleVisibility: .visible
      ) {
        ForEach(0..<viewModel.output.availableOverwriteSets.count, id: \.self) { index in
          let fudaSet = viewModel.output.availableOverwriteSets[index]
          Button("\(fudaSet.name) (\(fudaSet.state100.selectedNum)首)") {
            saveResult = viewModel.overwriteExistingFudaSet(at: index)
            showSuccessAlert = true
            router.saveSettings()
          }
        }

        Button("キャンセル", role: .cancel) { }
      }
  }

  private var saveActionSheet: ActionSheet {
    var buttons: [ActionSheet.Button] = []

    buttons.append(
      .default(Text("新しい札セットとして保存する")) {
        newSetName = ""
        showNewSetNameAlert = true
      }
    )

    if !viewModel.output.availableOverwriteSets.isEmpty {
      buttons.append(
        .default(Text("前に作った札セットを上書きする")) {
          showOverwritePickerAlert = true
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
      TextField("札セットの名前", text: $newSetName)

      HStack {
        Button("キャンセル") {
          newSetName = ""
        }

        Button("決定") {
          let result = viewModel.saveNewFudaSet(name: newSetName)
          if result.successMessage.isEmpty {
            showNoNameGivenAlert = true
          } else {
            newSetName = ""
            saveResult = result
            showSuccessAlert = true
            router.saveSettings()
          }
        }
      }
    }
  }
}

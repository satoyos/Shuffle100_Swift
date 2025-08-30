//
//  PoemPickerView.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/08/17.
//  Copyright © 2025 里 佳史. All rights reserved.
//

import SwiftUI

struct PoemPickerView {
  let settings: Settings
  @ObservedObject private var viewModel: PoemPickerView.ViewModel
  @Environment(\.isPresented) private var isPresented

  // アクション用のクロージャ
  var openNgramPickerAction: (() -> Void)?
  var openFudaSetsScreenAction: (() -> Void)?
  var openFiveColorsScreenAction: (() -> Void)?
  var openDigitsPicker01Action: (() -> Void)?
  var openDigitsPicker10Action: (() -> Void)?
  var showTorifudaAction: ((Int) -> Void)?
  var saveSetAction: (() -> Void)?

  init(settings: Settings) {
    self.settings = settings
    self.viewModel = PoemPickerView.ViewModel(settings: settings)
  }
}

extension PoemPickerView: View {
  var body: some View {
    NavigationStack {
      List {
        ForEach(viewModel.output.filteredPoems, id: \.number) { poem in
          PoemRow(
            poem: poem,
            isSelected: viewModel.isPoemSelected(poem.number),
            onTap: {
              viewModel.input.selectPoem.send(poem.number)
            },
            onDetailTap: {
              showTorifudaAction?(poem.number)
            }
          )
          .listRowInsets(EdgeInsets())
        }
      }
      .listStyle(PlainListStyle())
      .searchable(text: $viewModel.binding.searchText, prompt: "歌を検索")
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          saveButton
        }

        ToolbarItem(placement: .topBarTrailing) {
          badgeView
        }

        ToolbarItemGroup(placement: .bottomBar) {
          cancelAllButton
          Spacer()
          selectAllButton
          Spacer()
          selectByGroupButton
        }
      }
    }
    .onAppear {
      viewModel.refreshFromSettings()
    }
    .onChange(of: isPresented) { oldValue, newValue in
      guard !newValue else { return }
      tasksForLeavingThisView()
    }
  }

  private var saveButton: some View {
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

  private var badgeView: some View {
    Text("\(viewModel.output.selectedCount)首")
      .font(.caption)
      .foregroundColor(.white)
      .padding(.horizontal, 8)
      .padding(.vertical, 4)
      .background(Color.red)
      .cornerRadius(12)
  }

  private var cancelAllButton: some View {
    Button("全て取消") {
      viewModel.input.cancelAll.send()
    }
  }

  private var selectAllButton: some View {
    Button("全て選択") {
      viewModel.input.selectAll.send()
    }
  }

  private var selectByGroupButton: some View {
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

  // MARK: - Save Set UI Components
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


  func tasksForLeavingThisView() {
    // 設定は既にViewModelで更新済みのため、ここでは何もしない
  }
}

#Preview {
  PoemPickerView(settings: Settings(previewSamples: true))
}
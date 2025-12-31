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
  @ObservedObject var viewModel: PoemPickerView.ViewModel
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


  private var badgeView: some View {
    BadgeView(number: viewModel.output.selectedCount)
  }

  func tasksForLeavingThisView() {
    // 設定は既にViewModelで更新済みのため、ここでは何もしない
  }
}



#Preview {
  PoemPickerView(settings: Settings(previewSamples: true))
}
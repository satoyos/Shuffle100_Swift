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
    .onChange(of: isPresented) { oldValue, newValue in
      guard !newValue else { return }
      tasksForLeavingThisView()
    }
  }
  
  private var saveButton: some View {
    Button("保存") {
      guard viewModel.output.selectedCount > 0 else {
        // UIKit版ではアラート表示していたが、ここではアクションを呼ぶのみ
        saveSetAction?()
        return
      }
      saveSetAction?()
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
    Menu("まとめて選ぶ") {
      Button("10の位の数で選ぶ") {
        openDigitsPicker10Action?()
      }
      
      Button("1の位の数で選ぶ") {
        openDigitsPicker01Action?()
      }
      
      Button("五色百人一首の色で選ぶ") {
        openFiveColorsScreenAction?()
      }
      
      Button("1字目で選ぶ") {
        openNgramPickerAction?()
      }
      
      if !settings.savedFudaSets.isEmpty {
        Button("作った札セットから選ぶ") {
          openFudaSetsScreenAction?()
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
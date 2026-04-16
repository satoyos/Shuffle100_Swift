//
//  FudaSetsView.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/01/13.
//  Copyright © 2025 里 佳史. All rights reserved.
//

import SwiftUI

struct FudaSetsView {
  let settings: Settings
  @ObservedObject private var viewModel: FudaSetsView.ViewModel

  init(settings: Settings) {
    self.settings = settings
    self.viewModel = FudaSetsView.ViewModel(settings: settings)
  }
}

extension FudaSetsView: View {
  var body: some View {
    List {
      ForEach(viewModel.output.savedFudaSets.indices, id: \.self) { index in
        FudaSetRow(
          fudaSet: viewModel.output.savedFudaSets[index],
          isSelected: viewModel.output.selectedIndex == index,
          onTap: {
            viewModel.input.selectFudaSet.send(index)
          }
        )
        // シンプリにForEachの.onDeleteアクションを採用すると、
        // UIテストに失敗するため、↓このような複雑な実装を採用した。
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
          Button("削除", role: .destructive) {
            viewModel.input.deleteFudaSet.send(IndexSet([index]))
          }
          .accessibilityIdentifier("deleteFudaSet_\(viewModel.output.savedFudaSets[index].name)")
        }
      }
    }
    .listStyle(PlainListStyle())
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Text("札セット数: \(viewModel.output.savedFudaSets.count)")
          .foregroundColor(.secondary)
      }
    }
  }
}

struct FudaSetRow: View {
  let fudaSet: SavedFudaSet
  let isSelected: Bool
  let onTap: () -> Void
  
  var body: some View {
    HStack {
      Text(fudaSet.name)
        .font(.headline)
        .foregroundColor(isSelected ? .white : .primary)
      Spacer()
      Text("\(fudaSet.state100.selectedNum)首")
        .font(.subheadline)
        .foregroundColor(isSelected ? .white : .secondary)
    }
    .padding(.vertical, 4)
    .padding(.horizontal, 16)
    .background(isSelected ? Color.accentColor : Color.clear)
    .contentShape(Rectangle())
    .onTapGesture {
      onTap()
    }
  }
}

#Preview {
  FudaSetsView(settings: Settings(previewSamples: true))
}

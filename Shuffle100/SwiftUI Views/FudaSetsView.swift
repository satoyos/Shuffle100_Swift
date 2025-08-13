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
  @Environment(\.isPresented) private var isPresented
  
  init(settings: Settings) {
    self.settings = settings
    self.viewModel = FudaSetsView.ViewModel(savedFudaSets: settings.savedFudaSets)
  }
}

extension FudaSetsView: View {
  var body: some View {
    NavigationStack {
      List {
        ForEach(viewModel.output.savedFudaSets.indices, id: \.self) { index in
          FudaSetRow(
            fudaSet: viewModel.output.savedFudaSets[index],
            isSelected: viewModel.output.selectedIndex == index,
            onTap: {
              viewModel.input.selectFudaSet.send(index)
            }
          )
        }
        .onDelete { indexSet in
          viewModel.input.deleteFudaSet.send(indexSet)
        }
      }
      .listStyle(PlainListStyle())
      .safeAreaInset(edge: .top) {
        HStack {
          Spacer()
          Text("札セット数: \(viewModel.output.savedFudaSets.count)")
            .padding()
            .foregroundColor(.secondary)
        }
        .frame(height: 30)
      }
    }
    .onChange(of: isPresented) {
      guard !isPresented else { return }
      tasksForLeavingThisView()
    }
  }
  
  func tasksForLeavingThisView() {
    settings.savedFudaSets = viewModel.output.savedFudaSets
    settings.state100 = viewModel.output.selectedState100
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
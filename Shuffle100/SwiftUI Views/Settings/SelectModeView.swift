//
//  SelectModeView.swift
//  Shuffle100
//

import SwiftUI

struct SelectModeView: View {
  let viewModel: ViewModel

  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      Picker("読み上げモード", selection: viewModel.selectedMode) {
        ForEach(viewModel.reciteModeHolders, id: \.mode) { holder in
          Text(holder.title)
            .tag(holder.mode)
        }
      }
      .pickerStyle(.wheel)
      .labelsHidden()

      Spacer()
    }
    .padding()
    .navigationTitle("読み上げモードを選ぶ")
    .background(Color(uiColor: StandardColor.backgroundColor))
  }
}

#Preview {
  NavigationStack {
    SelectModeView(viewModel: .init(
      settings: Settings(),
      reciteModeHolders: [
        ReciteModeHolder(mode: .normal, title: "通常 (競技かるた)"),
        ReciteModeHolder(mode: .beginner, title: "初心者 (チラし取り)"),
        ReciteModeHolder(mode: .nonstop, title: "ノンストップ (止まらない)"),
        ReciteModeHolder(mode: .hokkaido, title: "下の句かるた (北海道式)")
      ]
    ))
  }
}

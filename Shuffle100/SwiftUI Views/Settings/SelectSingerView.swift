//
//  SelectSingerView.swift
//  Shuffle100
//

import SwiftUI

struct SelectSingerView: View {
  let viewModel: ViewModel

  // アラート状態（UI関心事）
  @State private var showAlert = false
  @State private var alertTitle = ""
  @State private var alertMessage = ""

  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      Picker("読み手", selection: viewModel.selectedSingerID) {
        ForEach(viewModel.singers, id: \.id) { singer in
          Text(singer.name)
            .tag(singer.id)
        }
      }
      .pickerStyle(.wheel)
      .labelsHidden()
      .onChange(of: viewModel.selectedSingerID.wrappedValue) { oldValue, newValue in
        // 選択変更時に検証を実行
        let validationResult = viewModel.validateSingerSelection(newValue)

        if case .invalid(let title, let message) = validationResult {
          // 検証失敗 -> アラート表示してデフォルトに戻す
          alertTitle = title
          alertMessage = message
          showAlert = true
          viewModel.selectedSingerID.wrappedValue = Singers.defaultSinger.id
        }
      }

      Spacer()
    }
    .padding()
    .navigationTitle("読手を選ぶ")
    .background(Color(uiColor: StandardColor.backgroundColor))
    .alert(alertTitle, isPresented: $showAlert) {
      Button("OK") { }
    } message: {
      Text(alertMessage)
    }
  }
}

#Preview {
  NavigationStack {
    SelectSingerView(viewModel: .init(
      settings: Settings(),
      singers: Singers.all
    ))
  }
}

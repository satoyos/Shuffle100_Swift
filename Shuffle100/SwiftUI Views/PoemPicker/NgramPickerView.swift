//
//  NgremPickerView.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/05/17.
//

import SwiftUI

struct NgramPickerView {
  let settings: Settings
  @ObservedObject private var viewModel: NgramPickerViewModel
  @Environment(\.isPresented) private var isPresented

  init(settings: Settings) {
    self.settings = settings
    self.viewModel = .init(state100: settings.state100)
  }
}

extension NgramPickerView: View {
  var body: some View {
    NavigationStack {
      List {
        ForEach(NgramSections.default) { section in
          Section(header: Text(section.title)) {
            ForEach(section.firstChars) { char in
              NgramButton(viewModel: char.buttonViewModel) {
                viewModel.input.chrButotnTapped.send(char)
              }
            }
          }
        }
      }
      //
      // 本当は、以下のように toolbarを使って実装したい。
      //
//      .toolbar {
//        ToolbarItem(placement: .confirmationAction) {
//          BadgeView(number: viewModel.selectedNum)
//        }
//        ToolbarItem(placement: .principal) {
//          Text("1字目で選ぶ")
//        }
//      }
      //
      // ただ、Shuffle100がまだUIKitからこのViewを呼び出しているので、
      //  表示の整合性のために、次のように saveAreaInsetを使う
      //
      .safeAreaInset(edge: .top) {
        HStack {
          Spacer()
          BadgeView(number: viewModel.output.state100.selectedNum)
            .padding()
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
    settings.state100 = viewModel.output.state100
  }
}

#Preview {
  NgramPickerView(settings: Settings())
}

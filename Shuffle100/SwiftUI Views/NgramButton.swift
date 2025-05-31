//
//  NgramButton.swift
//  TrialButtonAnimation
//
//  Created by Yoshifumi Sato on 2025/05/16.
//

import SwiftUI

struct NgramButton {
  @ObservedObject var viewModel: NgramButtonViewModel
  
  let action: () -> Void
  @EnvironmentObject var screensizeStore: ScreenSizeStore
}

extension NgramButton: View {
  var body: some View {
    Button(action: action) {
      HStack(spacing: 20) {
        Image(viewModel.output.fillType.ngramImageName)
          .resizable()
          .frame(width: 50, height: 50)

        Text(viewModel.firstChar.title)
          .font(.title2)
          .frame(maxWidth: .infinity,
                 alignment: .leading)
      }
    }
    .padding(.horizontal, 30)
  }
}

#Preview {
  NgramButton(viewModel: .init(firstChar: .u)) {
    print("押されました！")
  }
    .environmentObject(ScreenSizeStore())
}

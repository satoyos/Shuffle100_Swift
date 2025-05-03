//
//  FiveColorButton.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/03/29.
//

import SwiftUI

struct FiveColorButton {
  @ObservedObject var viewModel: FiveColorButtonViewModel
  
//  let ofColor: FiveColors
//  let fillType: FillType
  let action: () -> Void
  @EnvironmentObject var screenSizeStore: ScreenSizeStore
}

extension FiveColorButton: View {
  var body: some View {
    Button(action: action) {
      HStack(spacing: 20){
        Image(viewModel.output.fillType.fiveColorsImageName)
          .resizable()
          .renderingMode(.template)
          .foregroundColor(viewModel.color.color)
          .frame(width: imageHeight, height: imageHeight)
        Text(viewModel.color.description)
          .font(.title2)
          .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
    .padding(.horizontal, 50)
//    .background(Color.cyan)
    

  }
  private var imageHeight: CGFloat {
    screenSizeStore.screenHeight / 10.0
  }
}

#Preview {
  FiveColorButton(viewModel: .init(color: .yellow)) {
    print("押されたよん")
  }
    .environmentObject(ScreenSizeStore())
}

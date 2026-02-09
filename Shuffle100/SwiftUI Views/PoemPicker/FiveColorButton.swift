//
//  FiveColorButton.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/03/29.
//

import SwiftUI

struct FiveColorButton {
  @ObservedObject var viewModel: FiveColorButtonViewModel
  let containerHeight: CGFloat
  let action: () -> Void
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
  }

  private var imageHeight: CGFloat {
    containerHeight / 10.0
  }
}

#Preview {
  FiveColorButton(
    viewModel: .init(color: .yellow),
    containerHeight: UIScreen.main.bounds.height) {
    print("押されたよん")
  }
}

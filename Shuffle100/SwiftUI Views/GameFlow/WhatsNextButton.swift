//
//  WhatsNextButton.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/10/19.
//

import SwiftUI

struct WhatsNextButton: View {
  let imageName: String
  let title: String
  let buttonHeight: CGFloat
  let action: () -> Void

  var body: some View {
    Button(action: action) {
      HStack(spacing: buttonHeight * 0.5) {
        Image(imageName)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(height: buttonHeight)
        Text(title)
          .font(.title2)
          .foregroundColor(buttonColor)
          .frame(maxWidth: .infinity, alignment: .leading)
      }
      .frame(maxWidth: .infinity)
      .frame(height: buttonHeight)
    }
    .padding(.horizontal)
  }

  private var buttonColor: Color {
    Color(uiColor: StandardColor.standardButtonColor)
  }
}

#Preview {
  WhatsNextButton(
    imageName: "torifuda",
    title: "取り札を見る",
    buttonHeight: 60
  ) {
    print("押されたよん")
  }
}

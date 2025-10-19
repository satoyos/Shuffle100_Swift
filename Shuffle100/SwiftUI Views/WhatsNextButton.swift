//
//  WhatsNextButton.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/10/19.
//

import SwiftUI

struct WhatsNextButton {
  let imageName: String
  let title: String
  let action: () -> Void
  @EnvironmentObject var screenSizeStore: ScreenSizeStore
}

extension WhatsNextButton: View {
  var body: some View {
    Button(action: action) {
      HStack(spacing: buttonHeight * 0.5) {
        Image(imageName)
          .resizable()
          .frame(width: buttonHeight, height: buttonHeight)
        Text(title)
          .font(.title2)
          .foregroundColor(buttonColor)
          .frame(maxWidth: .infinity, alignment: .leading)
      }
      .frame(width: buttonWidth, height: buttonHeight)
    }
  }

  private var buttonWidth: CGFloat {
    screenSizeStore.screenWidth * 0.8
  }

  private var buttonHeight: CGFloat {
    let sizes = SizeFactory.createSizeByDevice()
    return sizes.whatsNextButtonHeight
  }

  private var buttonColor: Color {
    Color(uiColor: StandardColor.standardButtonColor)
  }
}

#Preview {
  WhatsNextButton(
    imageName: "torifuda",
    title: "取り札を見る"
  ) {
    print("押されたよん")
  }
  .environmentObject(ScreenSizeStore())
}

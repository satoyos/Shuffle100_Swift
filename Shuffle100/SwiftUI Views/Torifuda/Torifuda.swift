//
//  Torifuda.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2024/04/21.
//  Copyright © 2024 里 佳史. All rights reserved.
//

import SwiftUI

// 札が、superviewのどれくらいを占めたいか。
private let occupyRatio: CGFloat = 2.0 / 3.0

// 札の各種実測サイズ (単位はmm)
private let fudaHeightMeasured: CGFloat = 73.0 // 高さ
private let fudaWidthMeasured: CGFloat = 53.0  // 幅
private let greenOffsetMeasured: CGFloat = 2.0 // 緑枠の太さ
// アスペクト比 (幅/高さ)
private let fudaAspectRatio: CGFloat = fudaWidthMeasured / fudaHeightMeasured
// 文字のフォント

private let fudaFontSizeBase: CGFloat = 11

struct Torifuda: View {
  let viewModel: ViewModel
  let containerSize: CGSize

  var body: some View {
    let height = fudaHeight
    let ratioOnScreen = height / fudaHeightMeasured
    let width = fudaWidthMeasured * ratioOnScreen
    let greenOffset = greenOffsetMeasured * ratioOnScreen
    let widthInsideOfGreenFrame = width - 2 * greenOffset
    let heightInsideOfGreenFrame = height - 2 * greenOffset
    let font = Font.custom("HiraMinProN-W6", fixedSize: fudaFontSizeBase * ratioOnScreen)
    let charWidth = widthInsideOfGreenFrame / 3
    let charHeight = heightInsideOfGreenFrame / 5

    ZStack {
      Image(decorative: "washi_darkgreen")
        .resizable()
        .frame(width: width, height: height)
      Rectangle()
        .foregroundColor(.init(uiColor: UIColor(hex: "FFF7E5")))
        .frame(
          width: widthInsideOfGreenFrame,
          height: heightInsideOfGreenFrame)
      HStack(spacing: 0) {
        ForEach(0..<3) { col in
          VStack(spacing: 0) {
            ForEach(0..<5) { row in
              Text(viewModel.strForPosition(row: row, col: col))
                .font(font)
                .foregroundColor(.black)
                .frame(
                  width: charWidth,
                  height: charHeight)
            }
          }
        }
      }
    }.accessibilityIdentifier("fudaView")
  }

  private var fudaHeight: CGFloat {
    [heightByContainerWidth, heightByContainerHeight].min() ?? 300
  }

  private var heightByContainerHeight: CGFloat {
    containerSize.height * occupyRatio
  }

  private var heightByContainerWidth: CGFloat {
    containerSize.width / fudaAspectRatio * occupyRatio
  }
}

#Preview {
  Torifuda(
    viewModel: .init(shimo: "かたふくまてのつきをみしかな"),
    containerSize: UIScreen.main.bounds.size)
}

//
//  FullLiner.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2024/04/21.
//  Copyright © 2024 里 佳史. All rights reserved.
//

import SwiftUI

fileprivate let fontSizeBase: CGFloat = 17
fileprivate let minimumScreenHeight: CGFloat = 667.0
fileprivate let fontName = "HiraMinProN-W6"

struct FullLiner {
  let viewModel: ViewModel
  let containerHeight: CGFloat
}

extension FullLiner: View {
  var body: some View {
    let power = containerHeight / minimumScreenHeight
    let fontSize = fontSizeBase * power
    let font = Font.custom(fontName, fixedSize: fontSize)

    VStack {
      Text(viewModel.text)
        .font(font)
        .lineSpacing(fontSize / 2)
        .padding(.all, 10)
        .background(.white.opacity(0.5))
        .foregroundColor(.black)
    }
  }
}

#Preview {
  FullLiner(
    viewModel: .init(fullLiner: ["やすらはで", "ねなまし物を", "さよ更けて", "かたふくまでの", "月を見しかな"]),
    containerHeight: UIScreen.main.bounds.height)
}

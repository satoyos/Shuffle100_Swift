//
//  TrialTorifudaView.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2024/04/20.
//  Copyright © 2024 里 佳史. All rights reserved.
//

import SwiftUI

struct TorifudaView {
  let shimoStr: String
  let fullLiner: [String]
}

extension TorifudaView: View {
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        TatamiBackground()
        VStack {
          Spacer()
          Torifuda(
            viewModel: .init(shimo: shimoStr),
            containerSize: geometry.size)
          Spacer()
          FullLiner(
            viewModel: .init(fullLiner: fullLiner),
            containerHeight: geometry.size.height)
          Spacer()
        }
      }
    }
  }
}


#Preview {
  TorifudaView(
    shimoStr: "かたふくまてのつきをみしかな",
    fullLiner: ["やすらはで", "ねなまし物を", "さよ更けて", "かたふくまでの", "月を見しかな"])
}

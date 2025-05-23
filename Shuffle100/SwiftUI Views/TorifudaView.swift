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
  @EnvironmentObject var screenSizeStore: ScreenSizeStore
}
 
extension TorifudaView: View {
  var body: some View {
    GeometryReader { rootViewGeometry in
      ZStack {
        TatamiBackground()
        VStack {
          Spacer()
          Torifuda(viewModel: .init(shimo: shimoStr))
          Spacer()
          FullLiner(viewModel: .init(fullLiner: fullLiner))
          Spacer()
        }
      }
      .onAppear{
        screenSizeStore.update(
          width: rootViewGeometry.size.width,
          height: rootViewGeometry.size.height)
      }
      .onChange(of: rootViewGeometry.size) {
        screenSizeStore.update(
          width: rootViewGeometry.size.width,
          height: rootViewGeometry.size.height)
      }
    }
  }
}


#Preview {
  TorifudaView(
    shimoStr: "かたふくまてのつきをみしかな",
    fullLiner: ["やすらはで", "ねなまし物を", "さよ更けて", "かたふくまでの", "月を見しかな"]
  )
  .environmentObject(ScreenSizeStore())
}

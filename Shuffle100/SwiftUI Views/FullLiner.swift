//
//  FullLiner.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2024/04/21.
//  Copyright © 2024 里 佳史. All rights reserved.
//

import SwiftUI

private let fudaFontSizeBase: CGFloat = 17

struct FullLiner: View {
    let viewModel: ViewModel
    let font =  Font.custom("HiraMinProN-W6",
                            fixedSize: fudaFontSizeBase)

    var body: some View {
        VStack {
            Spacer()
            Text(viewModel.text)
                .font(font)
                .lineSpacing(fudaFontSizeBase / 2)
            //                .background(.white.opacity(0.4))
                .padding(.all, 10)
                .background(.white.opacity(0.5))
                .foregroundColor(.black)
                .padding(.bottom, fudaFontSizeBase * 2)
        }

    
    }
}

#Preview {
    FullLiner(viewModel: .init(fullLiner: ["やすらはで", "ねなまし物を", "さよ更けて", "かたふくまでの", "月を見しかな"]))
}

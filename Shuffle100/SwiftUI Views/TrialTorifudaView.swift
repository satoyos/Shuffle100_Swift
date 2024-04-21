//
//  TrialTorifudaView.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2024/04/20.
//  Copyright © 2024 里 佳史. All rights reserved.
//

import SwiftUI

struct TrialTorifudaView: View {
    let shimoStr: String
    let fullLiner: String
    
    var body: some View {
        VStack {
            Spacer() // 上部にスペースを追加して下のテキストが下に移動するのを助ける
            Text(shimoStr)
                .font(.title)
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity) // 画面中央に配置
                .cornerRadius(10)
                .padding(.bottom, 20) // 下側の余白を追加
            Text(fullLiner)
                .font(.headline)
                .padding()
                .background(.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            
        }
    }
}

#Preview {
    TrialTorifudaView(
        shimoStr: "かたふくまてのつきをみしかな",
        fullLiner: "やすらはで ねなまし物を さよ更けて かたふくまでの つきをみしかな"
    )
}

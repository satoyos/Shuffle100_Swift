//
//  TatamiBackground.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2024/04/21.
//  Copyright © 2024 里 佳史. All rights reserved.
//

import SwiftUI

struct TatamiBackground: View {
    var body: some View {
        Image(decorative: "tatami")
            .resizable()
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    TatamiBackground()
}

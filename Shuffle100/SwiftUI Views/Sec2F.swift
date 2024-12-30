//
//  Sec2F.swift
//  TrialButtonAnimation
//
//  Created by Yoshifumi Sato on 2024/08/20.
//

import SwiftUI

struct Sec2F {
    let digitSize: CGFloat
    let unitSize: CGFloat
    @ObservedObject private var viewModel: Sec2FViewModel
    
    init(digitSize: CGFloat, viewModel: Sec2FViewModel = .init(startTime: 2.00, interval: 0.02)) {
        self.digitSize = digitSize
        self.viewModel = viewModel
        self.unitSize = digitSize / 4
    }
}

extension Sec2F: View {
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            Text(viewModel.output.secText)
                .monospacedDigit()
                .font(.system(size: digitSize, weight: .medium))
            Text("秒")
                .font(.system(size: unitSize))
        }
    }
}

#Preview {
    Sec2F(digitSize: 100)
}

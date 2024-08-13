//
//  MemorizeTimer.swift
//  TrialButtonAnimation
//
//  Created by Yoshifumi Sato on 2024/07/27.
//

import SwiftUI

struct MemorizeTimer {
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject var screenSizeStore: ScreenSizeStore
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
}

extension MemorizeTimer: View {
    var body: some View {
        VStack {
            MinSec(digitSize: digitSize, viewModel: viewModel.timeViewModel)
            RecitePlayButton(
                diameter: buttonDiameter,
                viewModel: viewModel.buttonViewModel)
            .disabled(viewModel.isButtonDisabled)
        }
    }
    
    private var buttonDiameter: Double {
        screenSizeStore.screenWidth * 150.0 / 400.0
    }
    
    private var digitSize: CGFloat {
        screenSizeStore.screenWidth * 100.0 / 400.0
    }
}

#Preview {
    MemorizeTimer(
        viewModel: .init(totalSec: 11,
                         completion: {print("** All finished **")}))
    .environmentObject(ScreenSizeStore())
}

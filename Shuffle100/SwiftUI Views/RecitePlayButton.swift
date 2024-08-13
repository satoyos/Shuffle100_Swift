//
//  RecitePlayButton.swift
//  TrialButtonAnimation
//
//  Created by Yoshifumi Sato on 2024/07/22.
//

import SwiftUI

struct RecitePlayButton {
    @ObservedObject var viewModel: ViewModel
    var diameteer: Double
    
    init(diameter: Double = 300, viewModel: ViewModel) {
        self.diameteer = diameter
        self.viewModel = viewModel
    }
}

extension RecitePlayButton: View {
    var body: some View {
        ReciteViewGeneralButton(type: viewModel.type, diameter: diameteer) {
            viewModel.playButtonTapped()
        }
    }
}

#Preview {
    RecitePlayButton(viewModel: RecitePlayButton.ViewModel(type: .play))
}

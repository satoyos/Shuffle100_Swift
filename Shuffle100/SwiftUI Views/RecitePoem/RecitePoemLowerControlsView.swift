//
//  RecitePoemLowerControlsView.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/09/23.
//

import SwiftUI

struct RecitePoemLowerControlsView: View {
  let progressValue: Float
  let rewindAction: () -> Void
  let forwardAction: () -> Void
  let controlSize: Double
  let playButtonWidth: Double

  var body: some View {
    HStack(spacing: 0) {
      // Rewind Button
      ReciteViewGeneralButton(
        type: .rewind,
        diameter: controlSize
      ) {
        rewindAction()
      }
      .frame(width: controlSize, height: controlSize)

      Spacer()

      // Progress View
      // UIKit版の計算式: playButtonSize().width - 2.0 * skipButtonSize().width * 1.2
      ProgressView(value: progressValue)
        .progressViewStyle(LinearProgressViewStyle(tint: .accentColor))
        .frame(width: playButtonWidth - 2.0 * controlSize * 1.2, height: 5)

      Spacer()

      // Forward Button
      ReciteViewGeneralButton(
        type: .forward,
        diameter: controlSize
      ) {
        forwardAction()
      }
      .frame(width: controlSize, height: controlSize)
    }
  }
}

#Preview {
  RecitePoemLowerControlsView(
    progressValue: 0.6,
    rewindAction: { print("Rewind tapped") },
    forwardAction: { print("Forward tapped") },
    controlSize: 40.0,
    playButtonWidth: 300.0
  )
}
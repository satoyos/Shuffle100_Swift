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

  var body: some View {
    HStack(spacing: 20) {
      // Rewind Button
      ReciteViewGeneralButton(
        type: .rewind,
        diameter: controlSize
      ) {
        rewindAction()
      }

      Spacer()

      // Progress View
      ProgressView(value: progressValue)
        .progressViewStyle(LinearProgressViewStyle(tint: .accentColor))
        .frame(height: 4)

      Spacer()

      // Forward Button
      ReciteViewGeneralButton(
        type: .forward,
        diameter: controlSize
      ) {
        forwardAction()
      }
    }
    .padding(.horizontal, 20)
  }
}

#Preview {
  RecitePoemLowerControlsView(
    progressValue: 0.6,
    rewindAction: { print("Rewind tapped") },
    forwardAction: { print("Forward tapped") },
    controlSize: 50.0
  )
}
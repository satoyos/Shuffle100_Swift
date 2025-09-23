//
//  RecitePoemHeaderView.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/09/23.
//

import SwiftUI

struct RecitePoemHeaderView: View {
  let title: String
  let gearAction: () -> Void
  let exitAction: () -> Void

  var body: some View {
    HStack {
      Button(action: gearAction) {
        Image("gear-520")
          .renderingMode(.template)
          .resizable()
          .frame(width: 32, height: 32)
          .foregroundColor(.indigo)
      }
      .accessibilityLabel("gear")

      Spacer()

      Text(title)
        .font(.headline)
        .foregroundColor(.primary)
        .accessibilityIdentifier("screenTitle")

      Spacer()

      Button(action: exitAction) {
        Image("exit_square")
          .renderingMode(.template)
          .resizable()
          .frame(width: 32, height: 32)
          .foregroundColor(.indigo)
      }
      .accessibilityLabel("exit")
    }
    .padding(.horizontal, 10)
    .padding(.vertical, 10)
    .background(Color(StandardColor.barTintColor))
  }
}

#Preview {
  RecitePoemHeaderView(
    title: "1首め:上の句 (全100首)",
    gearAction: { print("Gear tapped") },
    exitAction: { print("Exit tapped") }
  )
}
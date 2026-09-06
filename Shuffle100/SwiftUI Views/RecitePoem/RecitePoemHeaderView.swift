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
          .foregroundColor(iconColor)
      }
      .modifier(HeaderButtonAppearance())
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
          .frame(width: 27.2, height: 27.2)
          .foregroundColor(iconColor)
      }
      .modifier(HeaderButtonAppearance())
      .accessibilityLabel("exit")
    }
    .padding(.horizontal, horizontalPadding)
    .padding(.vertical, verticalPadding)
    .background(Color(StandardColor.barTintColor))
  }

  // MARK: - Helper Properties

  private var horizontalPadding: CGFloat {
    if #available(iOS 26, *) { return 16 }
    return 10
  }

  private var verticalPadding: CGFloat {
    if #available(iOS 26, *) { return 4 }
    return 10
  }

  private var iconColor: Color {
    if #available(iOS 26, *) {
      return .primary
    } else {
      return .indigo
    }
  }
}

private struct HeaderButtonAppearance: ViewModifier {
  @ViewBuilder
  func body(content: Content) -> some View {
    content
      .buttonStyle(.plain)
      .frame(width: 44, height: 44)
      .contentShape(Circle())
    // 独自ヘッダーを回転対象に残し、バーと同系色のガラスで外観を揃える。
      .glassEffect(
        .regular.tint(Color(StandardColor.barTintColor).opacity(0.3)).interactive(),
        in: .circle
      )
  }
}

#Preview {
  RecitePoemHeaderView(
    title: "1首め:上の句 (全100首)",
    gearAction: { print("Gear tapped") },
    exitAction: { print("Exit tapped") }
  )
}

//
//  BadgeView.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/04/20.
//

import SwiftUI

struct BadgeView {
  private var number: Int
  @State private var scale: CGFloat = 1.0
  
  init(number: Int) {
    self.number = number
  }
}

extension BadgeView: View {
  var body: some View {
    Text("\(number)首")
      .font(.body)
      .foregroundColor(.white)
      .padding(5)
      .background(Color.red)
      .clipShape(RoundedRectangle(cornerRadius: 100))
      .scaleEffect(scale)
      .onChange(of: number) {
        animateBounce()
      }
  }
  
  private func animateBounce() {
    // 一瞬膨らんでから戻るアニメーション
    withAnimation(.easeOut(duration: 0.1)) {
      scale = 1.2
    }
    // 元のサイズに戻す
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      withAnimation(.easeIn(duration: 0.1)) {
        scale = 1.0
      }
    }
  }
}

#Preview {
  BadgeView(number: 3)
}

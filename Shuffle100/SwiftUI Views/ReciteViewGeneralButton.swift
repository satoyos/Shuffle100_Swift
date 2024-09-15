//
//  ReciteViewGeneralButton.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2024/07/13.
//

import SwiftUI

struct ReciteViewGeneralButton {
    let type: LabelType
    let diameter: Double
    @State private var isPressed: Bool = false
    let action: (() -> Void)?
    
    init(type: LabelType = .play, diameter: Double = 200, isPressed: Bool = false, action: (() -> Void)?) {
        self.type = type
        self.diameter = diameter
        self.isPressed = isPressed
        self.action = action
    }
}

extension ReciteViewGeneralButton: View {
    var body: some View {
        Button {
            action?()
        } label: {
            Image(systemName: name(of: type))
                .resizable()
        }
        .buttonStyle(ReciteViewButtonStyle(type: type, diameter: diameter))
        .scaleEffect(isPressed ? 0.9 : 1)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    withAnimation(.linear) {
                        isPressed = true
                    }
                }
                .onEnded { _ in
                    withAnimation(.interactiveSpring(response: 0.35, dampingFraction: 0.3)) {
                        isPressed = false
                    }
                }
        )
        .accessibilityIdentifier(type.rawValue)
    }
}

extension ReciteViewGeneralButton {
    enum LabelType: String {
        case play
        case pause
        case forward
        case rewind
    }
    
    private func name(of type: LabelType) -> String {
        switch type {
        case .play: return "play.fill"
        case .pause: return "pause.fill"
        case .forward: return "forward.fill"
        case .rewind: return "backward.fill"
        }
    }
}

#Preview {
    ReciteViewGeneralButton(type: .forward, diameter: 200) {}
}

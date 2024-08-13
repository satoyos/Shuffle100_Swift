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
                .frame(width: markSize, height: markSize)
                .padding(insets(of: type))
                .foregroundColor(forgroundColor(of: type))
                .frame(width: diameter, height: diameter)
                .background(backGradient)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .background(Circle()
                    .fill(.background).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/))
                // transaction below make Image swith WITHOUT animation!
                .transaction { transaction in
                    transaction.animation = nil
                }
        }
        
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
    private var markSize: Double {
        diameter * 0.5
    }
    
    private var markOffset: Double {
        diameter * 5 / 160
    }
    
    private var backGradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [Color("circle_button_back_top"), Color("circle_button_back_bottom")]),
                       startPoint: .top, endPoint: .bottom)
    }
}

extension ReciteViewGeneralButton {
    enum LabelType: String {
        case play
        case pause
        case forward
        case rewind
    }
}

extension ReciteViewGeneralButton {
    private func labelConfig(of type: LabelType) -> (imageName: String, paddingInsets: EdgeInsets, color: Color) {
        let playColor = Color("waiting_for_play")
        let pauseColor = Color("waiting_for_pause")
        
        switch type {
        case .play:
            return (imageName: "play.fill",
                    paddingInsets: EdgeInsets(top: 0, leading: markOffset * 3, bottom: 0, trailing: -1 * markOffset),
                    color: playColor)
        case .pause:
            return (imageName: "pause.fill",
                    paddingInsets: EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0),
                    color: pauseColor)
        case .forward:
            return (imageName: "forward.fill",
                    paddingInsets: EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: -1 * markOffset),
                    color: playColor)
        case .rewind:
            return (imageName: "backward.fill",
                    paddingInsets: EdgeInsets(top: 0, leading: -1 * markOffset, bottom: 0, trailing: markOffset),
                    color: playColor)
        }
    }
    
    private func name(of type: LabelType) -> String {
        labelConfig(of: type).imageName
    }
    
    private func insets(of type: LabelType) ->  EdgeInsets {
        labelConfig(of: type).paddingInsets
    }
    
    private func forgroundColor(of type: LabelType) -> Color {
        labelConfig(of: type).color
    }
}

#Preview {
    ReciteViewGeneralButton(type: .play, diameter: 300) {}
}

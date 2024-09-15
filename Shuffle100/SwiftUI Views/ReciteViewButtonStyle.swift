//
//  ReciteViewButtonStyle.swift
//  TrialButtonAnimation
//
//  Created by Yoshifumi Sato on 2024/08/14.
//

import SwiftUI

struct ReciteViewButtonStyle {
    @Environment(\.isEnabled) var isEnabled
    
    let type: ReciteViewGeneralButton.LabelType
    let diameter: Double
    @State private var _isPressed: Bool = false
}

extension ReciteViewButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: markSize, height: markSize)
            .padding(insets(of: type))
            .foregroundColor(isEnabled ? forgroundColor(of: type) : .gray)
            .frame(width: diameter, height: diameter)
            .background(backGradient)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .background(Circle()
                .fill(.background).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/))
        // transaction below make Image switch WITHOUT animation!
            .transaction { transaction in
                transaction.animation = nil
            }
    }
}
      
extension ReciteViewButtonStyle {
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

extension ReciteViewButtonStyle {
    private func labelConfig(of type: ReciteViewGeneralButton.LabelType) -> (paddingInsets: EdgeInsets, color: Color) {
        let playColor = Color("waiting_for_play")
        let pauseColor = Color("waiting_for_pause")
        
        switch type {
        case .play:
            return (paddingInsets: EdgeInsets(top: 0, leading: markOffset * 3, bottom: 0, trailing: -1 * markOffset),
                    color: playColor)
        case .pause:
            return (paddingInsets: EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0),
                    color: pauseColor)
        case .forward:
            return (paddingInsets: EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: -1 * markOffset),
                    color: playColor)
        case .rewind:
            return (paddingInsets: EdgeInsets(top: 0, leading: -1 * markOffset, bottom: 0, trailing: markOffset),
                    color: playColor)
        }
    }

    private func insets(of type: ReciteViewGeneralButton.LabelType) ->  EdgeInsets {
        labelConfig(of: type).paddingInsets
    }
    
    private func forgroundColor(of type:  ReciteViewGeneralButton.LabelType) -> Color {
        labelConfig(of: type).color
    }
}

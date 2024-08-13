//
//  ReciteViewPlayButton.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/09/08.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

final class ReciteViewPlayButton: ReciteViewButton {
    let colorWaitingForPause = UIColor.dynamicColor(light: SHColor.shoujouhi.UIColor, dark: SHColor.tsutsujiiro.UIColor)
    let colorWaitingForPlay = SHColor.konpeki.UIColor
    var fontSize: CGFloat?
    
    func configurePlayButton(height: CGFloat, fontSize: CGFloat, iconType: SOHGlyphIconType, leftInset: Bool = false) {
        super.configure(height: height, fontSize: fontSize, iconType: iconType)
        self.fontSize = fontSize
        switch iconType {
        case .play:
            showAsWaitingFor(.play)
        case .pause:
            showAsWaitingFor(.pause)
        default:
            fatalError("Icon Type [\(iconType)] is not supported!")
        }
    }
    
    func showAsWaitingFor(_ waitingFor: WaitingFor) {
        var config = self.configuration ?? UIButton.Configuration.plain()
        switch waitingFor {
        case .play:
            config.title = stringExpression(of: .play)
            config.baseForegroundColor = colorWaitingForPlay
            config.contentInsets = NSDirectionalEdgeInsets(
                top: 0,
                leading: fontSize! * 0.3,
                bottom: 0,
                trailing: 0)            
            self.accessibilityIdentifier = "waitingForPlay"
        case .pause:
            config.title = stringExpression(of: .pause)
            config.baseForegroundColor = colorWaitingForPause
            config.contentInsets = NSDirectionalEdgeInsets(
                top: 0, leading: 0, bottom: 0, trailing: 0)
            self.accessibilityIdentifier = "waitingForPause"
        }
        self.configuration = config
    }
}

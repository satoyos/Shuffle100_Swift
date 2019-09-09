//
//  ReciteViewPlayButton.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/09/08.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit
import FontAwesome_swift

class ReciteViewPlayButton: ReciteViewButton {
    let colorWaitingForPause = Color.shoujouhi.UIColor
    let colorWaitingForPlay = Color.konpeki.UIColor
    
    func configurePlayButton(height: CGFloat, fontSize: CGFloat, iconType: FontAwesome, leftInset: Bool = false) {
        super.configure(height: height, fontSize: fontSize, iconType: iconType)
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
        switch waitingFor {
        case .play:
            self.setTitle(String.fontAwesomeIcon(name: .play), for: .normal)
            self.setTitleColor(colorWaitingForPlay, for: .normal)
            self.contentEdgeInsets = UIEdgeInsets(top: 0, left: (titleLabel?.font.pointSize)! * 0.3, bottom: 0, right: 0)
        case .pause:
            self.setTitle(String.fontAwesomeIcon(name: .pause), for: .normal)
            self.setTitleColor(colorWaitingForPause, for: .normal)
            self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}

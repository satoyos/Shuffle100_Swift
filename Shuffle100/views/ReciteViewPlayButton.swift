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
    func configurePlayButton(height: CGFloat, fontSize: CGFloat, iconType: FontAwesome, leftInset: Bool = false) {
        super.configure(height: height, fontSize: fontSize, iconType: iconType)
        if leftInset {
            self.contentEdgeInsets = UIEdgeInsets(top: 0, left: fontSize * 0.3, bottom: 0, right: 0)
        }
    }
}

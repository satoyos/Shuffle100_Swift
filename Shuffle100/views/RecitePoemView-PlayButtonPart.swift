//
//  RecitePoemView-PlayButtonPart.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/07/13.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit
import SnapKit

extension RecitePoemView {
    internal func layoutPlayButton() {
        self.addSubview(playButton)
        configurePlayButton()
        playButton.snp.makeConstraints{(make) -> Void in
            make.centerX.equalToSuperview()
            make.size.equalTo(playButtonSize())
        }
    }
    
    private func configurePlayButton() {
        playButton.configurePlayButton(height: playButtonSize().height, fontSize: playButtonFontSize(), iconType: .play, leftInset: true)
    }
    
    internal func playButtonSize() -> CGSize {
        CGSize(width: sizeByDevice.playButtonHeight, height: sizeByDevice.playButtonHeight)
    }
    
    private func playButtonFontSize() -> CGFloat {
        return playButtonSize().height * 0.5
    }
}


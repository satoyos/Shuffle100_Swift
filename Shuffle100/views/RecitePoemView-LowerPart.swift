//
//  RecitePoemView-LowerPart.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/07/13.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit
import SnapKit

extension RecitePoemView {
    internal func layoutLowerContainr() {
        self.addSubview(lowerContainer)
        lowerContainer.backgroundColor = .clear
        lowerContainer.snp.makeConstraints{(make) -> Void in
            make.width.equalTo(playButton)
            make.height.equalTo(skipButtonSize().height)
            make.centerX.equalToSuperview()
        }
        layoutRewindButton()
        layoutForwardButton()
        layoutProgressView()
    }
    
    private func layoutForwardButton() {
        lowerContainer.addSubview(forwardButton)
        configureForwardButton()
        forwardButton.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(skipButtonSize())
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    private func layoutRewindButton() {
        lowerContainer.addSubview(rewindButton)
        configureRewindButton()
        rewindButton.snp.makeConstraints{(make) -> Void in
            make.size.equalTo(skipButtonSize())
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }
    }
    
    private func configureForwardButton() {
        forwardButton.configure(height: skipButtonSize().height, fontSize: skipButtonFontSize(), iconType: .forward)
    }
    
    private func layoutProgressView() {
        lowerContainer.addSubview(progressView)
        progressView.snp.makeConstraints{(make) -> Void in
            make.center.equalToSuperview()
            
            make.size.equalTo(CGSize(width: playButtonSize().width - 2.0 * skipButtonSize().width * 1.2, height: 5))
        }
        
    }
    
    private func configureRewindButton() {
        rewindButton.configure(height: skipButtonSize().height, fontSize: skipButtonFontSize(), iconType: .rewind)
    }
    
    
    private func skipButtonSize() -> CGSize {
        return CGSize(width: sizeByDevice.skipButtonHeight(), height: sizeByDevice.skipButtonHeight())
    }
    
    private func skipButtonFontSize() -> CGFloat {
        return skipButtonSize().height * 0.4
    }
}

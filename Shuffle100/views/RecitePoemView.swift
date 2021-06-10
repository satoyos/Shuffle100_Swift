//
//  RecitePoemView.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/07/13.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

enum WaitingFor {
    case pause
    case play
}

final class RecitePoemView: UIView {
    
    let headerContainer = UIView()
    let lowerContainer = UIView()
    let space1 = UIView()
    let space2 = UIView()
    let space3 = UIView()
    let playButton = ReciteViewPlayButton()
    let rewindButton = ReciteViewButton()
    let forwardButton = ReciteViewButton()
    let progressView = UIProgressView()
    var gearButton: ReciteViewHeaderButton!
    var exitButton: ReciteViewHeaderButton!
    let sizeByDevice = SizeFactory.createSizeByDevice()
    var headerTitle = "To be Filled!"
    var jokaDescLabel: UILabel?
    
    func fixLayoutOn(baseView: UIView, offsetX: CGFloat = 0) {
        self.snp.remakeConstraints{(make) -> Void in
            make.top.equalTo(baseView.safeAreaInsets.top)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.left.equalToSuperview().offset(offsetX)
        }
        baseView.layoutSubviews()
    }
    
    fileprivate func backgroundColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemBackground
        } else {
            return .white
        }
    }
    
    func initView(title: String) {
        headerTitle = title
        self.backgroundColor = backgroundColor()
        layoutHeaderContainer()
        layoutPlayButton()
        layoutLowerContainr()
        setYaxisConstraints()
        setAccessibilityLabels()
    }
    
    func showAsWaitingFor(_ waitingFor: WaitingFor) {
        playButton.showAsWaitingFor(waitingFor)
    }
    
    func addNormalJokaDescLabel() {
        let label = NormalJokaDescLabel()
        label.text = "試合開始の合図として読まれる歌です。"
        label.sizeToFit()
        self.addSubview(label)
        label.snp.makeConstraints{ (make) -> Void in
            make.center.equalTo(space1)
        }
        self.jokaDescLabel = label
    }
    
    private func setYaxisConstraints() {
        self.addSubview(space1)
        self.addSubview(space2)
        self.addSubview(space3)
        space1.backgroundColor = .clear
        space2.backgroundColor = .clear
        space3.backgroundColor = .clear
        space1.snp.makeConstraints{(make) -> Void in
            make.width.equalTo(10)
            make.centerX.equalToSuperview()
            make.top.equalTo(headerContainer.snp.bottom)
            make.bottom.equalTo(playButton.snp.top)
        }
        space2.snp.makeConstraints{(make) -> Void in
            make.width.equalTo(10)
            make.height.equalTo(space1)
            make.centerX.equalToSuperview()
            make.top.equalTo(playButton.snp.bottom)
            make.bottom.equalTo(lowerContainer.snp.top)
        }
        space3.snp.makeConstraints{(make) -> Void in
            make.width.equalTo(10)
            make.height.equalTo(space2)
            make.centerX.equalToSuperview()
            make.top.equalTo(lowerContainer.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
    
    internal func setAccessibilityLabels() {
        playButton.accessibilityLabel = "play"
        forwardButton.accessibilityLabel = "forward"
        rewindButton.accessibilityLabel = "rewind"
    }
}

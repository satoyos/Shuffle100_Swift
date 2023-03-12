//
//  MemorizeTimerScreenLayout.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/08/06.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import SnapKit
import Then

fileprivate let timeFontScaler = 0.75
fileprivate let charFontScaler = 0.8

extension MemorizeTimerScreen {
    internal func layoutScreen() {
        configureTimerContainer()
        configurePlayButton()
    }
    
    private func configureTimerContainer() {
        _ = timerContaier.then {
            $0.snp.makeConstraints { make in
                let height = sizeByDevice.memorizeTimerLabelPointSize
                make.width.equalToSuperview()
                make.height.equalTo(height)
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
                    .offset(-1 * height / 2)
            }
            $0.addSubview(minLabel)
            $0.addSubview(secLabel)
            $0.addSubview(minCharLabel)
            $0.addSubview(secCharLabel)
        }
        configureMinCharLabel()
        configureMinLabel()
        configureSecLabel()
        configureSecCharLabel()
    }
    
    private func configureMinCharLabel() {
        let unitLabelSize = sizeByDevice.memorizeTimerLabelPointSize / 3.0
        _ = minCharLabel.then {
            $0.text = "分"
            $0.font = UIFont.systemFont(ofSize: unitLabelSize * charFontScaler)
            $0.snp.makeConstraints { make in
                make.size.equalTo(unitLabelSize)
                make.bottom.equalToSuperview()
                make.centerX.equalToSuperview()
                    .offset(-1 * unitLabelSize / 2)
            }
        }
    }
    
    private func configureMinLabel() {
        let labelSize = sizeByDevice.memorizeTimerLabelPointSize
        _ = minLabel.then {
            $0.text = "00"
            $0.font = UIFont.monospacedDigitSystemFont(
                    ofSize: labelSize * timeFontScaler,
                    weight: .medium)
            $0.textAlignment = .right
            $0.snp.makeConstraints { make in
                make.size.equalTo(labelSize)
                make.top.equalToSuperview()
                make.trailing.equalTo(minCharLabel.snp.leading)
            }
        }
    }
    
    private func configureSecLabel() {
        let labelSize = sizeByDevice.memorizeTimerLabelPointSize
        _ = secLabel.then {
            $0.text = "00"
            $0.font = UIFont.monospacedDigitSystemFont(
                    ofSize: labelSize * timeFontScaler,
                    weight: .medium)
            $0.textAlignment = .right
            $0.snp.makeConstraints { make in
                make.size.equalTo(labelSize)
                make.top.equalToSuperview()
                make.leading.equalTo(minCharLabel.snp.trailing)
            }
        }
    }
    
    private func configureSecCharLabel() {
        let unitLabelSize = sizeByDevice.memorizeTimerLabelPointSize / 3
        _ = secCharLabel.then {
            $0.text = "秒"
            $0.font = UIFont.systemFont(ofSize: unitLabelSize * charFontScaler)
            $0.snp.makeConstraints { make in
                make.size.equalTo(unitLabelSize)
                make.bottom.equalToSuperview()
                make.leading.equalTo(secLabel.snp.trailing)
            }
        }
    }
    
    private func configurePlayButton() {
        let buttonSize = sizeByDevice.memorizeTimerLabelPointSize
        _ = playButton.then {
            $0.configurePlayButton(height: buttonSize, fontSize: buttonSize / 2, iconType: .play, leftInset: true)
            $0.snp.makeConstraints { make in
                make.size.equalTo(buttonSize)
                make.centerX.equalToSuperview()
                make.top.equalTo(timerContaier.snp.bottom)
                    .offset(buttonSize / 3)
            }
            $0.accessibilityLabel = "play"
        }
    }
}

//
//  TimeSettingScreenLayout.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/04/15.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import SnapKit

extension TimeSettingViewController {
    
    internal func layoutScreen() {
        configureTimeLabel()
        configureSlider()
        confitureTryButton()
    }
    
    private func configureTimeLabel() {
        _ = timeLabel.then {
            $0.text = "0.00"
            $0.font = UIFont.systemFont(ofSize: labelPointSize())
            $0.sizeToFit()
            $0.snp.makeConstraints{ (make) -> Void in
                // Center => [50%, 40%]
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(-1 * one10thOfViewHeight())
            }
        }
    }
    
    private func confitureTryButton() {
        _ = tryButton.then {
            $0.setTitle("試しに聞いてみる", for: .normal)
            $0.setTitleColor(StandardColor.standardButtonColor, for: .normal)
            $0.setTitleColor(UIColor.lightGray, for: .disabled)
            $0.sizeToFit()
            $0.snp.makeConstraints{ (make) -> Void in
                make.centerX.equalToSuperview()
                make.top.equalTo(slider.snp.bottom).offset(0.5 * one10thOfViewHeight())
            }
        }
    }

    private func configureSlider() {
        _ = slider.then {
            $0.snp.makeConstraints{ (make) -> Void in
                make.width.equalTo(0.8 * viewWidth())
                make.height.equalTo(sliderHeight())
                make.centerX.equalToSuperview()
                make.top.equalTo(timeLabel.snp.bottom).offset(blankBetweenLabelAndSlider())
            }
            $0.minimumValue = minIntervalDuration
            $0.maximumValue = maxIntervalDuration
//            $0.value = settings.interval
            $0.value = initialTime
            $0.accessibilityLabel = "slider"
        }
        updateTimeLabel()
    }

    private func labelPointSize() -> CGFloat {
        return sizeByDevice.intervalTimeLabelPointSize()
    }
    
    private func one10thOfViewHeight() -> CGFloat {
        return 0.1 * viewHeiht()
    }
    
    private func blankBetweenLabelAndSlider() -> CGFloat {
        return sliderHeight()
    }

    private func sliderHeight() -> CGFloat {
        return sizeByDevice.intervalSiderHeight()
    }
    
    private func viewWidth() -> CGFloat {
        return self.view.frame.size.width
    }
    
    private func viewHeiht() -> CGFloat {
        return view.frame.size.height
    }

}

//
//  VolumeSettingScreenLayout.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/04/18.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import SnapKit
import Then

extension VolumeSettingViewController {
    
    internal func layoutScreen() {
        view.backgroundColor = StandardColor.backgroundColor
        configureSlider()
        configureTryButton()
    }
    
    private func configureSlider() {
        _ = slider.then {
            $0.snp.makeConstraints{ (make) -> Void in
                make.width.equalTo(0.8 * viewWidth())
                make.height.equalTo(sliderHeight())
                // Center => [50%, 40%]
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(-1 * one10thOfViewHeight())
            }
            $0.minimumValue = minVolume
            $0.maximumValue = maxVolume
            $0.value = settings.volume
            $0.accessibilityLabel = "slider"
        }
    }
    
    private func configureTryButton() {
        _ = tryButton.then {
            $0.setTitle("テスト音声を再生する", for: .normal)
            $0.setTitleColor(StandardColor.standardButtonColor, for: .normal)
            $0.setTitleColor(UIColor.lightGray, for: .disabled)
            $0.sizeToFit()
            $0.snp.makeConstraints{ (make) -> Void in
                make.centerX.equalToSuperview()
                make.top.equalTo(slider.snp.bottom).offset(0.5 * one10thOfViewHeight())
            }
        }
    }
    
    private func viewWidth() -> CGFloat {
        return self.view.frame.size.width
    }
    
    private func viewHeiht() -> CGFloat {
        return view.frame.size.height
    }

    private func one10thOfViewHeight() -> CGFloat {
        return 0.1 * viewHeiht()
    }
    
    private func sliderHeight() -> CGFloat {
        return sizeByDevice.intervalSiderHeight()
    }

}

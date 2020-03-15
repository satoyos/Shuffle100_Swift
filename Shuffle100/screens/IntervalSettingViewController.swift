//
//  IntervalSettingViewController.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/03/08.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import SnapKit

class IntervalSettingViewController: SettingsAttachedViewController {
    let timeLabel = UILabel()
    let slider = UISlider()
    private let sizeByDevice = SizeFactory.createSizeByDevice()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "歌の間隔の調整"
        view.backgroundColor = StandardColor.backgroundColor
        view.addSubview(timeLabel)
        view.addSubview(slider)
        configureTimeLabel()
        configureSlider()
    }
    
    private func configureTimeLabel() {
        timeLabel.text = "0.00"
        timeLabel.font = UIFont.systemFont(ofSize: labelPointSize())
        timeLabel.sizeToFit()
        timeLabel.snp.makeConstraints{ (make) -> Void in
            // Center => [50%, 40%]
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-1 * one10thOfViewHeight())
        }
    }
    
    private func labelPointSize() -> CGFloat {
        return sizeByDevice.intervalTimeLabelPointSize()
    }
    
    private func one10thOfViewHeight() -> CGFloat {
        return 0.1 * viewHeiht()
    }
    
    private func configureSlider() {
        slider.snp.makeConstraints{ (make) -> Void in
            make.width.equalTo(0.8 * viewWidth())
            make.height.equalTo(sliderHeight())
            make.centerX.equalToSuperview()
            make.top.equalTo(timeLabel.snp.bottom).offset(blankBetweenLabelAndSlider())
        }
    }

    private func blankBetweenLabelAndSlider() -> CGFloat {
        return sliderHeight()
    }

    private func sliderHeight() -> CGFloat {
        return sizeByDevice.intervalSiderHeight()
    }
    
    private func viewWidth() -> CGFloat {
        print("|<==>| viewWidth: \(self.view.frame.size.width)")
        return self.view.frame.size.width
    }
    
    private func viewHeiht() -> CGFloat {
        return view.frame.size.height
    }
}

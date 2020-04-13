//
//  KamiShimoIntervalSettingViewController.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/04/13.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import SnapKit

class KamiShimoIntervalSettingViewController: UIViewController {
    let timeLabel = UILabel()
    let slider = UISlider()
    private let sizeByDevice = SizeFactory.createSizeByDevice()
    var tryButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "上の句と下の句の間隔"
        view.backgroundColor = StandardColor.backgroundColor
        view.addSubview(timeLabel)
        configureTimeLabel()
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
    
    private func labelPointSize() -> CGFloat {
        return sizeByDevice.intervalTimeLabelPointSize()
    }
    
    private func one10thOfViewHeight() -> CGFloat {
        return 0.1 * viewHeiht()
    }
    
    private func viewHeiht() -> CGFloat {
        return view.frame.size.height
    }

}

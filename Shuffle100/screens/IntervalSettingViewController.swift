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
    var timeLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "歌の間隔の調整"
        view.backgroundColor = StandardColor.backgroundColor
        view.addSubview(timeLabel)
        configureTimeLabel()
    }
    
    private func configureTimeLabel() {
        timeLabel.text = "0.00"
        timeLabel.font = UIFont.systemFont(ofSize: 100)
        timeLabel.sizeToFit()
        timeLabel.snp.makeConstraints{ (make) -> Void in
            // Center => [50%, 40%]
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-0.1 * view.frame.size.height)
        }
    }
}

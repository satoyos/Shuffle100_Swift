//
//  IntervalSettingScreenDelegate.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/03/15.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

extension IntervalSettingViewController {
    @objc func sliderValueChanged(_ slider: UISlider) {
        updateTimeLabel()
    }
    
    @objc func tryButtonTapped(_ button: UIButton) {        print("「試しに聞いてみる」ボタンが押された！")
    }
}

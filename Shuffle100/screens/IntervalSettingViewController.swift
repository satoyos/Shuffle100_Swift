//
//  IntervalSettingViewController.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/03/08.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import SnapKit
import Then
import AVFoundation

final class IntervalSettingViewController: TimeSettingViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "歌の間隔の調整"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        deleteTimerIfNeeded()
        stopAndResetPlayerIfNeeded()
        settings.interval = slider.value
        self.saveSettingsAction?()
    }
    
    override internal func tryButtonAction() {
        setCurrentPlayer(with: shimoPlayer)
        pleyCurrentPlayerFromBeginning()
    }

}

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

final class IntervalSettingViewController: TimeSettingScreen {

    override func viewDidLoad() {
        self.initialTime = settings.interval
        self.title = "歌の間隔の調整"
        super.viewDidLoad()
    }
    
    override internal func reflectSliderValueToSettings() {
        settings.interval = slider.value
    }
    
    override internal func tryButtonAction() {
        setCurrentPlayer(with: shimoPlayer)
        pleyCurrentPlayerFromBeginning()
    }

    override internal func successfullyPlayerFinishedAction(_ player: AVAudioPlayer) {
        if player == shimoPlayer {
            startCountDownTimer()
        } else {
            assert(true, "試し聞きはこれにて終了！")
            tryButton.isEnabled = true
            updateTimeLabel()
        }
    }
    
    override func switchCurrentPlayerAfterCountDown() {
        self.currentPlayer = kamiPlayer
    }
    
    override func kamiPoemNumber() -> Int? {
        return 2
    }
}

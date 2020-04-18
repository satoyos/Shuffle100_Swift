//
//  KamiShimoIntervalSettingViewController.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/04/13.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import AVFoundation

class KamiShimoIntervalSettingViewController: TimeSettingViewController {

    override func viewDidLoad() {
        self.initialTime = settings.kamiShimoInterval
        self.title = "上の句と下の句の間隔"
        super.viewDidLoad()
    }
    
    override internal func reflectSliderValueToSettings() {
        settings.kamiShimoInterval = slider.value
    }
    
    override internal func tryButtonAction() {
        setCurrentPlayer(with: kamiPlayer)
        pleyCurrentPlayerFromBeginning()
    }
    
    override internal func successfullyPlayerFinishedAction(_ player: AVAudioPlayer) {
        if player == kamiPlayer {
            startCountDownTimer()
        } else {
            print("試し聞きはこれにて終了！")
            tryButton.isEnabled = true
            updateTimeLabel()
        }
    }
    
    override func switchCurrentPlayerAfterCountDown() {
        self.currentPlayer = shimoPlayer
    }
    
    override func kamiPoemNumber() -> Int? {
        return 1
    }
    
}

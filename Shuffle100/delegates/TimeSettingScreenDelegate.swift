//
//  TimeSettingScreenDelegate.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/04/13.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import AVFoundation

private let subtractDuration: Float = 0.02

extension TimeSettingViewController: AVAudioPlayerDelegate {

    @objc func tryButtonTapped(_ button: UIButton) {
        tryButtonAction()
    }
    
    @objc func sliderValueChanged(_ slider: UISlider) {
        stopAndResetPlayerIfNeeded()
        updateTimeLabel()
    }
    
    @objc func updateRemainTime(t: Timer) {
        self.remainTime -= subtractDuration
        if remainTime < subtractDuration {
            self.remainTime = 0.0
            deleteTimerIfNeeded()
            self.currentPlayer = kamiPlayer
            pleyCurrentPlayerFromBeginning()
        }
       updateTimeLabel(with: remainTime)
    }
    
    internal func stopAndResetPlayerIfNeeded() {
        if let currentPlayer = currentPlayer {
            currentPlayer.stop()
            self.currentPlayer = nil
        }
        tryButton.isEnabled = true
    }
    
    internal func pleyCurrentPlayerFromBeginning() {
        guard  let currentPlayer = currentPlayer else {
            assertionFailure("currentPlayerが設定されていません")
            return
        }
        tryButton.isEnabled = false
        currentPlayer.currentTime = 0.0
        currentPlayer.play()
    }
    
    internal func setCurrentPlayer(with player: AVAudioPlayer) {
        self.currentPlayer = player
    }
}

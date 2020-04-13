//
//  IntervalSettingScreenDelegate.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/03/15.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import AVFoundation

private let subtractDuration: Float = 0.02

extension IntervalSettingViewController {
//    @objc func sliderValueChanged(_ slider: UISlider) {
//        stopAndResetPlayerIfNeeded()
//        updateTimeLabel()
//    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if !flag { return }
        if player == shimoPlayer {
            startCountDownTimer()
        } else {
            print("試し聞きはこれにて終了！")
            tryButton.isEnabled = true
            updateTimeLabel()
        }
    }
    
    func startCountDownTimer() {
        self.remainTime = slider.value
        self.timer = Timer.scheduledTimer(timeInterval: Double(subtractDuration), target: self, selector: #selector(updateRemainTime), userInfo: nil, repeats: true)
    }
    
//    @objc func updateRemainTime(t: Timer) {
//        self.remainTime -= subtractDuration
//        if remainTime < subtractDuration {
//            self.remainTime = 0.0
//            deleteTimerIfNeeded()
//            self.currentPlayer = kamiPlayer
//            pleyCurrentPlayerFromBeginning()
//        }
//        self.updateTimeLabel(with: remainTime)
//    }
    
//    internal func stopAndResetPlayerIfNeeded() {
//        if let currentPlayer = currentPlayer {
//            currentPlayer.stop()
//            self.currentPlayer = nil
//        }
//        tryButton.isEnabled = true
//    }
    
//    private func pleyCurrentPlayerFromBeginning() {
//        guard  let currentPlayer = currentPlayer else {
//            assertionFailure("currentPlayerが設定されていません")
//            return
//        }
//        tryButton.isEnabled = false
//        currentPlayer.currentTime = 0.0
//        currentPlayer.play()
//    }
//    
}

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

extension IntervalSettingViewController: AVAudioPlayerDelegate {
    @objc func sliderValueChanged(_ slider: UISlider) {
        updateTimeLabel()
    }
    
    @objc func tryButtonTapped(_ button: UIButton) {
//        print("「試しに聞いてみる」ボタンが押された！")
        shimoPlayer.play()
        self.currentPlayer = shimoPlayer
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if !flag { return }
        if player == shimoPlayer {
//            print("これからカウントダウンに入って、2種目の上の句を読み上げる！")
            startCountDownTimer()
        } else {
            print("試し聞きはこれにて終了！")
            updateTimeLabel()
        }
    }
    
    func startCountDownTimer() {
        self.remainTime = slider.value
        self.timer = Timer.scheduledTimer(timeInterval: Double(subtractDuration), target: self, selector: #selector(updateRemainTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateRemainTime(t: Timer) {
        self.remainTime -= subtractDuration
        if remainTime < subtractDuration {
            self.remainTime = 0.0
            deleteTimerIfNeeded()
            kamiPlayer.play()
            self.currentPlayer = kamiPlayer
        }
        self.updateTimeLabel(with: remainTime)
    }
    
}

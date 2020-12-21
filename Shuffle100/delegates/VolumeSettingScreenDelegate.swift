//
//  VolumeSettingScreenDelegate.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/04/19.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import AVFoundation

extension VolumeSettingScreen: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag == false {
            assertionFailure("Playerの再生が正常に終了しなかった！")
            return
        }
        player.currentTime = 0.0
        tryButton.isEnabled = true
    }
    
    internal func setDelegate(ofPlayer player: AVAudioPlayer) {
        player.delegate = self
    }
    
    @objc func tryButtonTapped() {
        assert(true, "試し聴きのボタンが押された！")
        currentPlayer.play()
        tryButton.isEnabled = false
    }
    
    @objc func sliderValueChanged(_ slider: UISlider) {
        assert(true, "スライダーの値が変わった！")
        currentPlayer.volume = slider.value
    }
}

//
//  IntervalSettingScreenDelegate.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/03/15.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import AVFoundation

extension IntervalSettingViewController: AVAudioPlayerDelegate {
    @objc func sliderValueChanged(_ slider: UISlider) {
        updateTimeLabel()
    }
    
    @objc func tryButtonTapped(_ button: UIButton) {        print("「試しに聞いてみる」ボタンが押された！")
        shimoPlayer.play()
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if !flag { return }
        if player == shimoPlayer {
            //////////
            // ToDo Next:: Implement real count down!
            print("これからカウントダウンに入って、2種目の上の句を読み上げる！")
            sleep(1)
            //////////
            kamiPlayer.play()
        } else {
            print("試し聞きはこれにて終了！")
        }
    }
}

//
//  MemorizeTimerScreenDelegate.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/08/16.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import Foundation
import AVFoundation

extension MemorizeTimerViewController: AVAudioPlayerDelegate {
    internal func setDelegate(of player: AVAudioPlayer) {
        player.delegate = self
    }
    
    func playButtonTapped() {
        self.isTimerRunning = !isTimerRunning
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateRemainTime), userInfo: nil, repeats: true)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        guard player == playerStgartGame else { return }
        guard flag == true else { return }
        navigationController?.popViewController(animated: true)
    }
}

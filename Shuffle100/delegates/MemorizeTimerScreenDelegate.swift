//
//  MemorizeTimerScreenDelegate.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/08/16.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import Foundation
import AVFoundation

extension MemorizeTimerScreen: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        guard player == playerStgartGame else { return }
        guard flag == true else { return }
        navigationController?.popViewController(animated: true)
    }
}

extension MemorizeTimerScreen {
    internal func setDelegate(of player: AVAudioPlayer) {
        player.delegate = self
    }
    
    func playButtonTapped() {
        self.isTimerRunning = !isTimerRunning
    }
}

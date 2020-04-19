//
//  VolumeSettingScreenDelegate.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/04/19.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import AVFoundation

extension VolumeSettingViewController: AVAudioPlayerDelegate {
    internal func setDelegate(ofPlayer player: AVAudioPlayer) {
        player.delegate = self
    }
}

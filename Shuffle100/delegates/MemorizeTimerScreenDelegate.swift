//
//  MemorizeTimerScreenDelegate.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/08/16.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import Foundation

extension MemorizeTimerViewController {
    func playButtonTapped() {
        self.isTimerRunning = !isTimerRunning
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateRemainTime), userInfo: nil, repeats: true)
    }
}

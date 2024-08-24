//
//  CountdownTimer.swift
//  TrialButtonAnimation
//
//  Created by Yoshifumi Sato on 2024/07/26.
//

import Foundation
import Combine

class CountDownTimer: ObservableObject {
    // この変数の変化に同期する形でカウントダウンの数字、プログレスバーの表示に動きをつける
    @Published private(set) var remainTime: Double
    @Published private(set) var isRunning = false
    
    private let intarval: Double
    private var timer: Timer?
    
    init(startTime remainTime: Double, intarval: Double) {
        self.remainTime = remainTime
        self.intarval = intarval
    }
    
    deinit {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: intarval, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.remainTime -= self.intarval
            self.isRunning = true
            
            if self.remainTime <= 0 {
                self.remainTime = 0.0
                self.stopAneEraseTimer()
            }
        }
    }
    
    func stop() {
        stopAneEraseTimer()
    }
    
    private func stopAneEraseTimer() {
        self.timer?.invalidate()
        self.timer = nil
        self.isRunning = false
    }
}

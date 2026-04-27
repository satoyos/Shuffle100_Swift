//
//  CountdownTimer.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2024/07/26.
//

import Foundation
import Combine

class CountDownTimer: ObservableObject {
  // この変数の変化に同期する形でカウントダウンの数字、プログレスバーの表示に動きをつける
  @Published private(set) var remainTime: Double
  @Published private(set) var isRunning = false
  
  private let interval: Double
  private var timer: Timer?

  var isScheduled: Bool { timer != nil }

  init(startTime remainTime: Double, interval: Double) {
    self.remainTime = remainTime
    self.interval = interval
  }
  
  deinit {
    self.timer?.invalidate()
    self.timer = nil
  }
  
  func start() {
    let t = Timer(timeInterval: interval, repeats: true) { [weak self] _ in
      self?.tick()
    }
    RunLoop.main.add(t, forMode: .common)
    timer = t
  }

  func tick() {
    remainTime -= interval
    if isRunning == false {
      isRunning = true
    }
    if remainTime <= 0 {
      isRunning = false
      remainTime = 0.0
      stopAndEraseTimer()
    }
  }
  
  func stop() {
    stopAndEraseTimer()
  }
  
  func reset(to newTime: Double) {
    stop()
    self.remainTime = newTime
  }
  
  private func stopAndEraseTimer() {
    self.timer?.invalidate()
    self.timer = nil
    if isRunning {
      self.isRunning = false
    }
  }
}

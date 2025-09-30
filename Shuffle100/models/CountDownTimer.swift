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
  
  init(startTime remainTime: Double, interval: Double) {
    self.remainTime = remainTime
    self.interval = interval
  }
  
  deinit {
    self.timer?.invalidate()
    self.timer = nil
  }
  
  func start() {
    timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
      guard let self = self else { return }
      self.remainTime -= self.interval
      if self.isRunning == false {
        self.isRunning = true
      }
      
      if self.remainTime <= 0 {
        self.isRunning = false
        self.remainTime = 0.0
        self.stopAndEraseTimer()
      }
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

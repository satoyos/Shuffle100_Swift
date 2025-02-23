//
//  RecitePoemScreenDelegate.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/07/15.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

extension RecitePoemScreen {
  func selectPosrMortemOrBackToHome() {
    guard settings.postMortemEnabled else { return }
    currentPlayer?.stop()
    self.currentPlayer = nil
    let ac = UIAlertController(title: "感想戦を始めますか？", message: "今の試合と同じ順番に詩を読み上げる「感想戦」を始めることができます。", preferredStyle: .actionSheet)
    let backToHome = UIAlertAction(title: "トップに戻る", style: .default) { _ in
      self.backToHomeScreenAction?()
    }
    let startPostMortem = UIAlertAction(title: "感想戦を始める", style: .default) { _ in
      self.startPostMortemAction?()
    }
    let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
    ac.addAction(backToHome)
    ac.addAction(startPostMortem)
    ac.addAction(cancel)
    if let pc = ac.popoverPresentationController {
      guard let button = recitePoemView.exitButton else { return }
      pc.sourceView = button
      pc.sourceRect = CGRect(x: 0, y: 0, width: button.frame.width, height: button.frame.height)
    }
    present(ac, animated: true)
  }
  
  internal func settingsButtonTapped() {
    guard let player = currentPlayer else { return }
    if player.isPlaying {
      pauseCurrentPlayer()
    }
    self.openSettingsAction?()
  }
  
  internal func playButtonTapped() {
    if playFinished {
      self.playButtonTappedAfterFinishedReciting?()
    } else {
      flipPlaying()
    }
  }
  
  internal func flipPlaying() {
    guard let currentPlayer = currentPlayer else { return }
    if currentPlayer.isPlaying {
      pauseCurrentPlayer()
    } else {
      playCurrentPlayer()
    }
  }
  
  internal func playCurrentPlayer() {
    guard let currentPlayer = currentPlayer else { return }
    currentPlayer.play()
    recitePoemView.showAsWaitingFor(.pause)
  }
  
  internal func pauseCurrentPlayer() {
    guard let currentPlayer = currentPlayer else { return }
    currentPlayer.pause()
    recitePoemView.showAsWaitingFor(.play)
  }
  
  internal func rewindButtonTapped() {
    guard let currentPlayer = currentPlayer else { return }
    if currentPlayer.currentTime > 0.0 {
      currentPlayer.currentTime = 0.0
      pauseCurrentPlayer()
      updateAudioProgressView()
    } else {
      self.backToPreviousAction?()
    }
  }
  
  internal func forwardButtonTapped() {
    guard let currentPlayer = currentPlayer else { return }
    currentPlayer.stop()
    skipToNextScreenAction?()
  }
}

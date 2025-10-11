//
//  RecitePoemViewModel+AudioController.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/09/24.
//

import AVFoundation
import Foundation

extension RecitePoemViewModel {

  // MARK: - Audio Methods

  func playJoka(shorten: Bool = false) {
    currentPlayer = audioPlayerFactory.prepareOpeningPlayer(folder: singer.path)
    guard let player = currentPlayer else {
      print("序歌の音声ファイルが見つかりません。フォルダ[\(singer.path)]")
      return
    }

    if shorten {
      player.currentTime = Double(singer.shortenJokaStartTime)
      addShortJokaDescLabel()
    } else {
      addNormalJokaDescLabel()
    }

    startPlayingCurrentPlayer()
  }

  func playNumberedPoem(number: Int, side: Side) {
    currentPlayer = audioPlayerFactory.preparePlayer(number: number, side: side, folder: singer.path)
    guard currentPlayer != nil else {
      print("音声ファイルが見つかりません。歌番号[\(number)], フォルダ[\(singer.path)]")
      return
    }

    hideJokaDescLabels()
    startPlayingCurrentPlayer()
  }

  // MARK: - Internal Audio Control

  internal func startPlayingCurrentPlayer() {
    prepareCurrentPlayer()
    playCurrentPlayer()
    setTimerForProgressView()
  }

  internal func prepareCurrentPlayer() {
    guard let player = currentPlayer else { return }
    player.prepareToPlay()
    player.volume = settings.volume
    player.delegate = self
    playFinished = false
  }

  internal func playCurrentPlayer() {
    guard let player = currentPlayer else { return }
    player.play()
    showAsWaitingForPause()
  }

  internal func pauseCurrentPlayer() {
    guard let player = currentPlayer else { return }
    player.pause()
    showAsWaitingForPlay()
  }

  internal func flipPlaying() {
    guard let player = currentPlayer else { return }
    if player.isPlaying {
      pauseCurrentPlayer()
    } else {
      playCurrentPlayer()
    }
  }

  // MARK: - Progress Timer Management

  internal func setTimerForProgressView() {
    progressTimer?.invalidate()
    progressTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
      self?.updateAudioProgressView()
    }
  }

  @objc internal func updateAudioProgressView() {
    guard let player = currentPlayer else { return }
    binding.progressValue = Float(player.currentTime / player.duration)
  }

  // MARK: - AVAudioPlayerDelegate

  func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    binding.progressValue = 1.0
    playFinished = true
    input.audioPlayerFinished.send()
  }
}
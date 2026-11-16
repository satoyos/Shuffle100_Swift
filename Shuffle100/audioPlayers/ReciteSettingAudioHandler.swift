//
//  ReciteSettingAudioHandler.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2024/11/17.
//

import AVFoundation

final class ReciteSettingAudioHandler: NSObject,  AVAudioPlayerDelegate  {
  let player1: AVAudioPlayer?
  let player2: AVAudioPlayer?
  let folderPath: String
  var player1FinishedAction: (() -> Void)?
  var player2FinishedAction: (() -> Void)?
  private var pendingPlaybackIDs: [ObjectIdentifier: UUID] = [:]
  
  enum HalfPoem: String {
    case h001a
    case h001b
    case h002a
  }
  
  init(halfPoem1: HalfPoem = .h001a, halfPoem2: HalfPoem = .h001b, folderPath: String) {
    self.player1 = Self.fetchPlayer(of: halfPoem1, in: folderPath)
    self.player2 = Self.fetchPlayer(of: halfPoem2, in: folderPath)
    self.folderPath = folderPath
    super.init()
  }
  
  func startPlayer1() {
    guard let player1 = player1 else {
      print("Player1の音声ファイルが見つかりません")
      return
    }
    startPlaying(player1)
  }
  
  func startPlayer2() {
    guard let player2 = player2 else {
      print("Player2の音声ファイルが見つかりません")
      return
    }
    startPlaying(player2)
  }
  
  func stopAllPlayers() {
    pendingPlaybackIDs.removeAll()
    if let player1 = player1, player1.isPlaying {
      player1.stop()
    }
    if let player2 = player2, player2.isPlaying {
      player2.stop()
    }
  }
  
  func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    if let player1 = player1, player == player1 {
      player1FinishedAction?()
    } else if let player2 = player2, player == player2 {
      player2FinishedAction?()
    }
  }
  
  private static func fetchPlayer(of halfPoem: HalfPoem, in folderPath: String) -> AVAudioPlayer? {
    let filename = String(halfPoem.rawValue.dropFirst())
    return AudioPlayerFactory.shared.preparePlayer(folder: folderPath, file: filename, title: filename)
  }
  
  private static func fetchInabaPlayer(of halfPoem: HalfPoem) -> AVAudioPlayer? {
    let filename = String(halfPoem.rawValue.dropFirst())
    return AudioPlayerFactory.shared.preparePlayer(folder: "audio/inaba", file: filename, title: filename)
  }
  
  private func startPlaying(_ player: AVAudioPlayer) {
    let playerID = ObjectIdentifier(player)
    let playbackID = UUID()
    pendingPlaybackIDs[playerID] = playbackID

    Task { @MainActor [weak self, weak player] in
      guard let self, let player else { return }
      guard await AudioPlayerFactory.shared.setupAudioSession() else {
        self.finishPendingPlayback(player, playerID: playerID, playbackID: playbackID)
        return
      }
      guard self.pendingPlaybackIDs[playerID] == playbackID else { return }
      player.delegate = self
      player.currentTime = 0.0
      guard await AudioPlayerFactory.shared.startPlayback(player) else {
        self.finishPendingPlayback(player, playerID: playerID, playbackID: playbackID)
        return
      }
      guard self.pendingPlaybackIDs[playerID] == playbackID else {
        player.stop()
        return
      }
      self.pendingPlaybackIDs[playerID] = nil
    }
  }

  private func finishPendingPlayback(
    _ player: AVAudioPlayer,
    playerID: ObjectIdentifier,
    playbackID: UUID
  ) {
    guard pendingPlaybackIDs[playerID] == playbackID else { return }
    pendingPlaybackIDs[playerID] = nil
    notifyPlaybackFinished(player)
  }

  private func notifyPlaybackFinished(_ player: AVAudioPlayer) {
    if player === player1 {
      player1FinishedAction?()
    } else if player === player2 {
      player2FinishedAction?()
    }
  }
}

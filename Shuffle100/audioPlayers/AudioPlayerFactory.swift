//
//  AudioPlayerFactory.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/07/27.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class AudioPlayerFactory: AudioPlayerFactoryProtocol {
  static let shared = AudioPlayerFactory()

  private let audioSessionActivator = AudioSessionActivator()
  private let playbackPreparationQueue = DispatchQueue(
    label: "com.sato0123.Shuffle100.audio-player-preparation"
  )

  func setupAudioSession() async -> Bool {
    await MainActor.run {
      UIApplication.shared.beginReceivingRemoteControlEvents()
    }

    return await audioSessionActivator.activate()
  }

  func startPlayback(_ player: AVAudioPlayer) async -> Bool {
    await withCheckedContinuation { continuation in
      playbackPreparationQueue.async {
        guard player.prepareToPlay() else {
          continuation.resume(returning: false)
          return
        }
        continuation.resume(returning: player.play())
      }
    }
  }
  
  func prepareOpeningPlayer(folder: String) -> AVAudioPlayer? {
    return preparePlayer(folder: folder, file: "序歌", title: "序歌")
  }
  
  func preparePlayer(folder: String, file: String, ofType ext: String = "m4a", title: String?) -> AVAudioPlayer? {
    guard let path = Bundle.main.path(forResource: folder + "/" + file, ofType: ext) else {
      print("音源ファイルが見つかりません: \(folder)/\(file).\(ext)")
      return nil
    }
    do {
      let player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
      return player
    } catch {
      print("\(title ?? "音源")のAudioPlayer生成に失敗しました。folder => [\(folder)]\n - Error: \(error.localizedDescription)")
      return nil
    }
  }
  
  func preparePlayer(number: Int, side: Side, folder: String) -> AVAudioPlayer? {
    let file = String(format: "%03d", number) + tailForSide(side)
    let title = "歌番号[\(number)]"
    return preparePlayer(folder: folder, file: file, title: title)
  }
  
  private func tailForSide(_ side: Side) -> String {
    switch side {
    case .kami:
      return "a"
    case .shimo:
      return "b"
    }
  }
}

private actor AudioSessionActivator {
  private var activationTask: Task<Bool, Never>?
  private let legacyActivationQueue = DispatchQueue(
    label: "com.sato0123.Shuffle100.audio-session"
  )

  func activate() async -> Bool {
    if let activationTask {
      return await activationTask.value
    }

    let task = Task { [legacyActivationQueue] in
      await Self.activateSession(legacyActivationQueue: legacyActivationQueue)
    }
    activationTask = task

    let activated = await task.value
    activationTask = nil
    return activated
  }

  private static func activateSession(
    legacyActivationQueue: DispatchQueue
  ) async -> Bool {
    do {
      let session = AVAudioSession.sharedInstance()
      try await withCheckedThrowingContinuation { continuation in
        legacyActivationQueue.async {
          do {
            try session.setCategory(.playback, mode: .default)
            continuation.resume()
          } catch {
            continuation.resume(throwing: error)
          }
        }
      }

      if #available(iOS 27.0, *) {
        return try await session.activate()
      }

      return try await withCheckedThrowingContinuation { continuation in
        legacyActivationQueue.async {
          do {
            try AVAudioSession.sharedInstance().setActive(true)
            continuation.resume(returning: true)
          } catch {
            continuation.resume(throwing: error)
          }
        }
      }
    } catch {
      print("AudioSessionの初期設定時エラー: \(error.localizedDescription)")
      return false
    }
  }
}

//
//  RecitePoemViewModel+NowPlayingInfo.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/10/22.
//

import UIKit
import MediaPlayer

extension RecitePoemViewModel {
  internal func updateNowPlayingInfo(title: String) {
    var nowPlayingInfo = [String : Any]()
    nowPlayingInfo[MPMediaItemPropertyTitle] = title
    nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = self.currentPlayer?.currentTime
    nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = self.currentPlayer?.duration
    if let image = UIImage(named: "Shuffle100_1024_background_playback") {
      nowPlayingInfo[MPMediaItemPropertyArtwork] =
      MPMediaItemArtwork(boundsSize: image.size) { size in
        // Extension used here to return newly sized image
        return image.imageWith(newSize: size)
      }
    }
    // Set the metadata
    MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
  }

  internal func setupRemoteTransportControls() {
    // Get the shared MPRemoteCommandCenter
    let commandCenter = MPRemoteCommandCenter.shared()

    // Add handler for Play Command
    commandCenter.playCommand.addTarget { [unowned self] event -> MPRemoteCommandHandlerStatus in
      guard let currentPlayer = self.currentPlayer else { return .commandFailed}
      currentPlayer.play()
      return .success
    }

    // Add handler for Pause Command
    commandCenter.pauseCommand.addTarget { [unowned self] event -> MPRemoteCommandHandlerStatus in
      guard let currentPlayer = self.currentPlayer else { return .commandFailed}
      currentPlayer.pause()
      return .success
    }
  }
}

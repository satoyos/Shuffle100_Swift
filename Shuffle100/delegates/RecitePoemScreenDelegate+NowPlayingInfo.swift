//
//  RecitePoemScreenDelegate+NowPlayingInfo.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2022/09/19.
//  Copyright © 2022 里 佳史. All rights reserved.
//

import MediaPlayer

extension RecitePoemScreen {
    internal func updateNowPlayingInfo(title: String) {
        var nowPlayingInfo = [String : Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = title

        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = self.currentPlayer?.currentTime
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = self.currentPlayer?.duration
        
        // Set the metadata
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    @objc func onWillResignActive(_ notification: Notification?) {
        assert(true, "-- バックグラウンドに【これから入ります】 (Notificationで検出)")
        if settings.reciteMode != .nonstop {
            assert(true, "// ノンストップではないので、読み上げを止めます。")
            pauseCurrentPlayer()
        } else {
            setupRemoteTransportControls()
        }
    }
    
    private func setupRemoteTransportControls() {
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


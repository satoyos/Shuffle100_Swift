//
//  RecitePoemScreenDelegate.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/07/15.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

extension RecitePoemViewController {
    internal func exitButtonTapped() {
        let ac = UIAlertController(title: "試合を終了しますか？", message: nil, preferredStyle: .alert)
        let quit = UIAlertAction(title: "終了する", style: .cancel) {[weak self] action in
            self?.currentPlayer?.stop()
            self?.currentPlayer = nil
            _ = self?.navigationController?.popViewController(animated: true)
        }
        ac.addAction(quit)
        let cancel = UIAlertAction(title: "続ける", style: .default, handler: nil)
        ac.addAction(cancel)
        present(ac, animated: true)
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
        currentPlayer.currentTime = 0.0
        pauseCurrentPlayer()
        updateAudioProgressView()
    }
    
    internal func forwardButtonTapped() {
        guard let currentPlayer = currentPlayer else { return }
        currentPlayer.currentTime = currentPlayer.duration - 0.1
        currentPlayer.pause()
        updateAudioProgressView()
        currentPlayer.stop()
        audioPlayerDidFinishPlaying(currentPlayer, successfully: true)
    }
    
    internal func backToHomeScreen() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        keepProgressBarFilled(player)
        self.playFinished = true
        self.playerFinishedAction?()
    }
    
    fileprivate func keepProgressBarFilled(_ player: AVAudioPlayer) {
        player.currentTime = player.duration
    }
    
    @objc func onWillResignActive(_ notification: Notification?) {
        print("-- バックグラウンドに【これから入ります】 (Notificationで検出)")
        if settings.reciteMode != .nonstop {
            print("// ノンストップではないので、読み上げを止めます。")
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
    
    internal func updateNowPlayingInfo(title: String) {
        var nowPlayingInfo = [String : Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = title

        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = self.currentPlayer?.currentTime
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = self.currentPlayer?.duration
        
        // Set the metadata
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
}

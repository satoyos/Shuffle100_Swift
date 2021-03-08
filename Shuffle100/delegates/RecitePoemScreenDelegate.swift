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

extension RecitePoemScreen: AVAudioPlayerDelegate, ExitGameProtocol {
    
    func exitGame() {
        currentPlayer?.stop()
        self.currentPlayer = nil
        if settings.postMortemEnabled {
            let ac = UIAlertController(title: "感想戦を始めますか？", message: "今の試合と同じ順番に詩を読み上げる「感想戦」を始めることができます。", preferredStyle: .actionSheet)
            let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
            ac.addAction(cancel)
            if let pc = ac.popoverPresentationController {
                let button = gameEndView.backToHomeButton
                pc.sourceView = button
                pc.sourceRect = CGRect(x: 0, y: 0, width: button.frame.width, height: button.frame.height)
            }
            present(ac, animated: true)
        } else {
            //        _ = navigationController?.popViewController(animated: true)
            self.backToHomeScreenAction?()
        }
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
        if currentPlayer.isPlaying {
            currentPlayer.currentTime = currentPlayer.duration - 0.1
            currentPlayer.pause()
            updateAudioProgressView()
            currentPlayer.stop()
            audioPlayerDidFinishPlaying(currentPlayer, successfully: true)
        } else {
            self.skipToNextScreenAction?()
        }
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
    
    internal func updateNowPlayingInfo(title: String) {
        var nowPlayingInfo = [String : Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = title

        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = self.currentPlayer?.currentTime
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = self.currentPlayer?.duration
        
        // Set the metadata
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    internal func confirmStartingPostMortem() {
        let ac = UIAlertController(title: "感想戦を始めますか？", message: "今の試合と同じ歌を同じ順序で読み上げます", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel)
        let okAction = UIAlertAction(title: "始める", style: .default) { _ in
            print("++OK、感想戦を始めましょう")
            self.startPostMortemAction?()
        }
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        present(ac, animated: true)
    }
}

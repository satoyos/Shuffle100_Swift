//
//  RecitePoemScreenDelegate+Audio.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2022/06/24.
//  Copyright © 2022 里 佳史. All rights reserved.
//

import AVFoundation

extension RecitePoemScreen: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        keepProgressBarFilled(player)
        self.playFinished = true
        self.playerFinishedAction?()
    }
    
    private func prepareCurrentPlayer() {
        _ = currentPlayer?.then {
            $0.prepareToPlay()
            $0.volume = settings.volume
            $0.delegate = self
        }
        self.playFinished = false
    }
    
}
 
extension RecitePoemScreen {
    func playNumberedPoem(number: Int, side: Side, count: Int) {
        currentPlayer = AudioPlayerFactory.shared.preparePlayer(number: number, side: side, folder: singer.path)
        startPlayingCurrentPlayer(number: number, side: side, count: count)
    }

    fileprivate func updateNowPlayingInfoIfNeeded(count: Int?, side: Side?) {
        guard settings.reciteMode == .nonstop else { return }
        
        var title: String!
        if let count = count {
            guard let side = side else { return }
            var sideStr = ""
            if side == .kami {
                sideStr = "上"
            } else {
                sideStr = "下"
            }
            title = "\(count)首目 (\(sideStr)の句)"
        } else {
            title = "序歌"
        }
        updateNowPlayingInfo(title: title)
    }

    func playJoka(shorten: Bool = false) {
        currentPlayer = AudioPlayerFactory.shared.prepareOpeningPlayer(folder: singer.path)
        if shorten {
            currentPlayer?.currentTime = Double(singer.shortenJokaStartTime)
            recitePoemView.addShortJokaDescLabel()
        } else{
            recitePoemView.addNormalJokaDescLabel()
        }
        
        startPlayingCurrentPlayer(number: nil, side: nil, count: nil )
        
    }
    
    fileprivate func startPlayingCurrentPlayer(number: Int?, side: Side?, count: Int? ) {
        updateNowPlayingInfoIfNeeded(count: count, side: side)
        prepareCurrentPlayer()
        playCurrentPlayer()
        setTimerForProgressView()
    }

    fileprivate func setTimerForProgressView() {
        timerForPrgoress = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateAudioProgressView), userInfo: nil, repeats: true)
    }
    
    fileprivate func keepProgressBarFilled(_ player: AVAudioPlayer) {
        player.currentTime = player.duration
    }
}


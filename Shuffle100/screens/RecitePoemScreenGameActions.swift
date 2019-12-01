//
//  RecitePoemScreenGameActions.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/11/24.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

extension RecitePoemViewController {
    func playJoka() {
        currentPlayer = AudioPlayerFactory.shared.prepareOpeningPlayer(folder: singer.path)
        startPlayingCurrentPlayer()
    }
    
    func playNumberedPoem(number: Int, side: Side) {
        currentPlayer = AudioPlayerFactory.shared.preparePlayer(number: number, side: side, folder: singer.path)
        startPlayingCurrentPlayer()
    }

    fileprivate func setTimerForProgressView() {
        timerForPrgoress = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateAudioProgressView), userInfo: nil, repeats: true)
    }
    
    fileprivate func prepareCurrentPlayer() {
        _ = currentPlayer?.then {
            $0.prepareToPlay()
            $0.volume = settings.volume
            $0.delegate = self
        }
        self.playFinished = false
    }

    fileprivate func startPlayingCurrentPlayer() {
        prepareCurrentPlayer()
        playCurrentPlayer()
        setTimerForProgressView()
    }
    
    @objc func updateAudioProgressView() {
        guard let player = currentPlayer else { return }
        recitePoemView.progressView.setProgress(Float(player.currentTime / player.duration), animated: false)
    }
    
    func stepIntoNextPoem(number: Int, at counter: Int, total: Int) {
        UIView.transition(with: self.view, duration: 1.0, options: [.transitionFlipFromLeft, .layoutSubviews], animations: {
            let newReciteView = RecitePoemView()
            self.recitePoemView.removeFromSuperview()
            UIView.performWithoutAnimation {
                self.view.addSubview(newReciteView)
                newReciteView.initView(title: "\(counter)首め:上の句 (全\(total)首)")
            }
            self.recitePoemView = newReciteView
            self.addActionsToButtons()
        }, completion: { finished in
            self.reciteKami(number: number)
        })
    }
    
    func waitUserActionAfterFineshdReciing() {
        recitePoemView.showAsWaitingFor(.play)
    }
    
    private func reciteKami(number: Int) {
        playNumberedPoem(number: number, side: .kami)
    }

}

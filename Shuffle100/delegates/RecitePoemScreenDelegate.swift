//
//  RecitePoemScreenDelegate.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/07/15.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit
import AVFoundation

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
    
    internal func flipPlaying() {
        guard let currentPlayer = currentPlayer else {       return
        }
        if currentPlayer.isPlaying {
            // pause playing
            currentPlayer.pause()
            recitePoemView.showAsWaitingFor(.play)
        } else {
            // restart playing
            currentPlayer.play()
            recitePoemView.showAsWaitingFor(.pause)
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.playerFinishedAction?()
    }
}

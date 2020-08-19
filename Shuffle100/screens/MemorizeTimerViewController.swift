//
//  MemorizeTimerViewController.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/08/06.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import AVFoundation

class MemorizeTimerViewController: UIViewController {
    let timerContaier = UIView()
    let minLabel = UILabel()
    let secLabel = UILabel()
    let minCharLabel = UILabel()
    let secCharLabel = UILabel()
    let playButton = ReciteViewPlayButton()
    internal let sizeByDevice = SizeFactory.createSizeByDevice()
    var remainSec: Int = 15 * 60
    private var _isTimerRunning = false
    internal var timer: Timer!
    let player2minites = AudioPlayerFactory.shared.preparePlayer(folder: "audio/sasara", file: "2minutesLeft", title: "競技開始2分前")
    let playerStgartGame = AudioPlayerFactory.shared.preparePlayer(folder: "audio/sasara", file: "timeToStartGame", title: "暗記時間終了")
    
    var isTimerRunning: Bool {
        get {
            return _isTimerRunning
        }
        set {
            if _isTimerRunning {
                stopAndDeleteTimer()
                playButton.showAsWaitingFor(.play)
           } else {
                setAndStartTimer()
                playButton.showAsWaitingFor(.pause)
            }
            _isTimerRunning = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "暗記時間タイマー"
        view.backgroundColor = StandardColor.backgroundColor
        view.addSubview(timerContaier)
        view.addSubview(playButton)
        
        layoutScreen()
//        self.isTimerRunning = false
        setButtonActions()
        refleshLabels()
        setDelegate(of: playerStgartGame)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAndDeleteTimer()
    }
    
    internal func refleshLabels() {
        let min: Int = remainSec / 60
        let sec: Int = remainSec % 60
        minLabel.text = "\(min)"
        secLabel.text = String(format: "%02d", sec)
    }
    
    @objc func updateRemainTime() {
        remainSec -= 1
        refleshLabels()
        if remainSec == 2 * 60 {
            declare2minutesLeft()
        } else if remainSec == 0 {
            stopAndDeleteTimer()
            declareTimeToStartGame()
        }
        
    }

    private func setButtonActions() {
        playButton.tap = { [weak self] btn in
            self?.playButtonTapped()
        }
    }
    
    internal func setAndStartTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateRemainTime), userInfo: nil, repeats: true)
    }
    
    private func stopAndDeleteTimer() {
        if let timer = timer {
            timer.invalidate()
            self.timer = nil
        }
    }
    
    internal func declare2minutesLeft() {
        player2minites.currentTime = 0.0
        player2minites.play()
    }
    
    internal func declareTimeToStartGame() {
        playerStgartGame.currentTime = 0.0
        playerStgartGame.play()
        playButton.isEnabled = false
    }
}

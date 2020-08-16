//
//  MemorizeTimerViewController.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/08/06.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

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
    
    var isTimerRunning: Bool {
        get {
            return _isTimerRunning
        }
        set {
            _isTimerRunning = newValue
            if _isTimerRunning {
                playButton.showAsWaitingFor(.pause)
            } else {
                playButton.showAsWaitingFor(.play)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "暗記時間タイマー"
        view.backgroundColor = StandardColor.backgroundColor
        view.addSubview(timerContaier)
        view.addSubview(playButton)
        
        layoutScreen()
        self.isTimerRunning = false
        setButtonActions()
        refleshLabels()
    }
    
    internal func refleshLabels() {
        let min: Int = remainSec / 60
        let sec: Int = remainSec % 60
        minLabel.text = "\(min)"
        secLabel.text = String(format: "%02d", sec)
    }

    private func setButtonActions() {
        playButton.tap = { [weak self] btn in
            self?.playButtonTapped()
        }
    }
    
}

//
//  TimeSettingViewController.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/04/13.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import Then
import AVFoundation

internal let minIntervalDuration: Float = 0.5
internal let maxIntervalDuration: Float = 2.0

class TimeSettingViewController: SettingsAttachedViewController {
    let timeLabel = UILabel()
    let slider = UISlider()
    internal let sizeByDevice = SizeFactory.createSizeByDevice()
    var tryButton = UIButton()
    var initialTime: Float!
    var kamiPlayer: AVAudioPlayer!
    var shimoPlayer: AVAudioPlayer!
    var currentPlayer: AVAudioPlayer!
    var remainTime: Float = 0.0
    var timer: Timer!
    var tryBUttonAction: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = StandardColor.backgroundColor
        view.addSubview(timeLabel)
        view.addSubview(slider)
        view.addSubview(tryButton)
        layoutScreen()
        setSubviewsTarget()
        setKamiShimoPlayers()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        deleteTimerIfNeeded()
        stopAndResetPlayerIfNeeded()
        reflectSliderValueToSettings()
        self.saveSettingsAction?()
    }
    
    internal func setKamiShimoPlayers() {
        guard let singer = Singers.getSingerOfID(settings.singerID) else {
            assertionFailure("読手が見つかりません")
            return
        }
        guard let kamiPoemNumber = kamiPoemNumber() else {
            assertionFailure("上の句の歌番号が見つかりません")
            return
        }
        let singerFolder = singer.path
        self.kamiPlayer = AudioPlayerFactory.shared.preparePlayer(number: kamiPoemNumber, side: .kami, folder: singerFolder).then {
            $0.delegate = self
        }
        self.shimoPlayer = AudioPlayerFactory.shared.preparePlayer(number: 1, side: .shimo, folder: singerFolder).then {
            $0.delegate = self
        }
    }
    
    internal func updateTimeLabel() {
        updateTimeLabel(with: slider.value)
    }
    
    internal func updateTimeLabel(with time: Float) {
        timeLabel.text = String(format: "%.2F", time)
    }
    
    internal func deleteTimerIfNeeded() {
        if let timer = self.timer {
            timer.invalidate()
            self.timer = nil
        }
    }

    internal func reflectSliderValueToSettings() {
        assertionFailure("This method must be overwritten!!")
    }
    
    internal func tryButtonAction() {
        assertionFailure("This method must be overwritten!")
    }
    
    internal func successfullyPlayerFinishedAction(_ player: AVAudioPlayer) {
        assertionFailure("This method must be overwritten in subclass!!")
    }
    
    internal func switchCurrentPlayerAfterCountDown() {
        assertionFailure("This method must be overwritten!")
    }
    
    internal func kamiPoemNumber() -> Int? {
        assertionFailure("This method must be overwritten!")
        return nil
    }
    
    private func setSubviewsTarget() {
        tryButton.addTarget(self, action: #selector(tryButtonTapped), for: .touchUpInside)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }

}

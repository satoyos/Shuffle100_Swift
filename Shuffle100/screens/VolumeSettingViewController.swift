//
//  VolumeSettingViewController.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/04/18.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import SnapKit
import Then
import AVFoundation

let minVolume: Float = 0.0
let maxVolume: Float = 1.0

class VolumeSettingViewController: SettingsAttachedViewController {
    
    internal let sizeByDevice = SizeFactory.createSizeByDevice()
    var slider = UISlider()
    var tryButton = UIButton()
    var currentPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "音量の調整"
        view.addSubview(slider)
        view.addSubview(tryButton)
        layoutScreen()
        setSubviewsTarget()
        setPlayer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stopPlayer()
        reflectSliderValueToSettings()
    }

    private func setSubviewsTarget() {
        
    }
    
    private func setPlayer() {
        guard let singer = Singers.getSingerOfID(settings.singerID) else {
            assertionFailure("読手が見つかりません")
            return
        }
        let singerFolder = singer.path
        let kamiPlayer = AudioPlayerFactory.shared.preparePlayer(number: 1, side: .kami, folder: singerFolder).then {
            setDelegate(ofPlayer: $0)
        }
        self.currentPlayer = kamiPlayer
    }
    
    private func stopPlayer() {
        if let player = currentPlayer {
            player.stop()
        }
    }
    
    private func reflectSliderValueToSettings() {
        settings.volume = slider.value
        self.saveSettingsAction?()
    }
    
}

//
//  IntervalSettingViewController.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/03/08.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import SnapKit
import Then
import AVFoundation

private let minIntervalDuration: Float = 0.5
private let maxIntervalDuration: Float = 2.0

class IntervalSettingViewController: SettingsAttachedViewController {
    let timeLabel = UILabel()
    let slider = UISlider()
    private let sizeByDevice = SizeFactory.createSizeByDevice()
    var tryButton = UIButton()
    var kamiPlayer: AVAudioPlayer!
    var shimoPlayer: AVAudioPlayer!
    var currentPlayer: AVAudioPlayer!
    var remainTime: Float = 0.0
    var timer: Timer!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "歌の間隔の調整"
        view.backgroundColor = StandardColor.backgroundColor
        view.addSubview(timeLabel)
        view.addSubview(slider)
        view.addSubview(tryButton)
        configureTimeLabel()
        configureSlider()
        confitureTryButton()
        setKamiShimoPlayers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        deleteTimerIfNeeded()
        settings.interval = slider.value
        self.saveSettingsAction?()
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

    private func configureTimeLabel() {
        _ = timeLabel.then {
            $0.text = "0.00"
            $0.font = UIFont.systemFont(ofSize: labelPointSize())
            $0.sizeToFit()
            $0.snp.makeConstraints{ (make) -> Void in
                // Center => [50%, 40%]
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(-1 * one10thOfViewHeight())
            }
        }
    }
    
    private func confitureTryButton() {
        _ = tryButton.then {
            $0.setTitle("試しに聞いてみる", for: .normal)
            $0.setTitleColor(StandardColor.standardButtonColor, for: .normal)
            $0.setTitleColor(UIColor.lightGray, for: .disabled)
            $0.sizeToFit()
            $0.snp.makeConstraints{ (make) -> Void in
                make.centerX.equalToSuperview()
                make.top.equalTo(slider.snp.bottom).offset(0.5 * one10thOfViewHeight())
            }
            $0.addTarget(self, action: #selector(tryButtonTapped), for: .touchUpInside)
        }
    }
    
    private func labelPointSize() -> CGFloat {
        return sizeByDevice.intervalTimeLabelPointSize()
    }
    
    private func one10thOfViewHeight() -> CGFloat {
        return 0.1 * viewHeiht()
    }
    
    private func configureSlider() {
        _ = slider.then {
            $0.snp.makeConstraints{ (make) -> Void in
                make.width.equalTo(0.8 * viewWidth())
                make.height.equalTo(sliderHeight())
                make.centerX.equalToSuperview()
                make.top.equalTo(timeLabel.snp.bottom).offset(blankBetweenLabelAndSlider())
            }
            $0.minimumValue = minIntervalDuration
            $0.maximumValue = maxIntervalDuration
            $0.value = settings.interval
            $0.accessibilityLabel = "slider"
            $0.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        }
        updateTimeLabel()
    }

    private func blankBetweenLabelAndSlider() -> CGFloat {
        return sliderHeight()
    }

    private func sliderHeight() -> CGFloat {
        return sizeByDevice.intervalSiderHeight()
    }
    
    private func viewWidth() -> CGFloat {
        return self.view.frame.size.width
    }
    
    private func viewHeiht() -> CGFloat {
        return view.frame.size.height
    }
    
    private func setKamiShimoPlayers() {
        guard let singer = Singers.getSingerOfID(settings.singerID) else {
            assertionFailure("読手が見つかりません")
            return
        }
        let singerFolder = singer.path
        self.kamiPlayer = AudioPlayerFactory.shared.preparePlayer(number: 2, side: .kami, folder: singerFolder).then {
            $0.delegate = self
        }
        self.shimoPlayer = AudioPlayerFactory.shared.preparePlayer(number: 1, side: .shimo, folder: singerFolder).then {
            $0.delegate = self
        }
    }
}

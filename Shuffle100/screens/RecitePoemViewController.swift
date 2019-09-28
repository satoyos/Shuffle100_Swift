//
//  RecitePoemViewController.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/06/08.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit
import AVFoundation
import Then

class RecitePoemViewController: UIViewController, AVAudioPlayerDelegate {
    var recitePoemView: RecitePoemView!
    var settings: Settings!
    var currentPlayer: AVAudioPlayer?
    var timerForPrgoress: Timer!
    var playerFinishedAction: (() -> Void)?
    
    init(settings: Settings = Settings()) {
        self.settings = settings
        
        // クラスの持つ指定イニシャライザを呼び出す
        super.init(nibName: nil, bundle: nil)
    }
    
    // 新しく init を定義した場合に必須
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.natsumushi.UIColor
        recitePoemView = RecitePoemView()
        view.addSubview(recitePoemView)
        recitePoemView.initView(title: "序歌")
        addActionsToButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        recitePoemView.fixLayoutOn(baseView: self.view)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timerForPrgoress.invalidate()
    }
    
    func addActionsToButtons() {
        recitePoemView.exitButton.tappedAction = {[weak self] in
            self?.exitButtonTapped()
        }
        recitePoemView.playButton.tap = { [weak self] btn in
            self?.flipPlaying()
        }
        recitePoemView.rewindButton.tap = { [weak self] btn in
            self?.rewindButtonTapped()
        }
        recitePoemView.forwardButton.tap = { [weak self] btn in
            self?.forwardButtonTapped()
        }
    }
    
    func playJoka() {
        guard let folder = Singers.getSingerOfID(settings.singerID) else {
            print("[\(settings.singerID)]に対応する読手が見つかりません。")
            return }
    
        currentPlayer = AudioPlayerFactory.shared.prepareOpeningPlayer(folder: folder.path).then {
            $0.prepareToPlay()
            $0.volume = settings.volume
            $0.delegate = self
        }
        currentPlayer?.play()
        recitePoemView.showAsWaitingFor(.pause)
        timerForPrgoress = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateAudioProgressView), userInfo: nil, repeats: true)
    }
    
    @objc func updateAudioProgressView() {
        guard let player = currentPlayer else { return }
        recitePoemView.progressView.setProgress(Float(player.currentTime / player.duration), animated: false)
    }
}

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
    var singer: Singer!
    
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
        
        let singerID = settings.singerID
        guard let singer = fetchSinger(id: singerID) else {
            print("[\(singerID)]に対応する読手が見つかりません。")
            return
        }
        self.singer = singer

        view.backgroundColor = StandardColor.barTintColor
        recitePoemView = RecitePoemView()
        view.addSubview(recitePoemView)
        recitePoemView.initView(title: "序歌")
        addActionsToButtons()
    }
    
    fileprivate func fetchSinger(id: String) -> Singer? {
        return Singers.getSingerOfID(id)
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
        currentPlayer = AudioPlayerFactory.shared.prepareOpeningPlayer(folder: singer.path)
        prepareCurrentPlayer()
        currentPlayer?.play()
        recitePoemView.showAsWaitingFor(.pause)
        timerForPrgoress = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateAudioProgressView), userInfo: nil, repeats: true)
    }
    
    func playNumberedPoem(number: Int, side: Side) {
        currentPlayer = AudioPlayerFactory.shared.preparePlayer(number: number, side: side, folder: singer.path)
        prepareCurrentPlayer()
        currentPlayer?.play()
        recitePoemView.showAsWaitingFor(.pause)
        timerForPrgoress = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateAudioProgressView), userInfo: nil, repeats: true)
    }
    
    private func prepareCurrentPlayer() {
        _ = currentPlayer?.then {
            $0.prepareToPlay()
            $0.volume = settings.volume
            $0.delegate = self
        }
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
                newReciteView.initView(title: "\(counter)首め")
            }
            self.recitePoemView = newReciteView
            self.addActionsToButtons()
        }, completion: { finished in
            self.reciteKami(number: number)
        })
    }
    
    private func reciteKami(number: Int) {
        playNumberedPoem(number: number, side: .kami)
    }
}

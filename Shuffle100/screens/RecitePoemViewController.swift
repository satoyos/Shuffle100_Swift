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
    var gameEndView: GameEndViiew!
    var settings: Settings!
    var currentPlayer: AVAudioPlayer?
    var timerForPrgoress: Timer!
    var playerFinishedAction: (() -> Void)?
    var playButtonTappedAfterFinishedReciting: (() -> Void)?
    var backToPreviousAction: (() -> Void)?
    var skipToNextScreenAction: (() -> Void)?
    var singer: Singer!
    var playFinished: Bool = false
    
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
        
        setNotificationsAboutBackgound()
    }
    
    fileprivate func fetchSinger(id: String) -> Singer? {
        return Singers.getSingerOfID(id)
    }
        
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        recitePoemView?.fixLayoutOn(baseView: self.view)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let timerForPrgoress = self.timerForPrgoress {
            timerForPrgoress.invalidate()
        }
    }
    
    func addActionsToButtons() {
        recitePoemView.exitButton.tappedAction = {[weak self] in
            self?.exitButtonTapped()
        }
        recitePoemView.playButton.tap = { [weak self] btn in
//            self?.flipPlaying()
            self?.playButtonTapped()
        }
        recitePoemView.rewindButton.tap = { [weak self] btn in
            self?.rewindButtonTapped()
        }
        recitePoemView.forwardButton.tap = { [weak self] btn in
            self?.forwardButtonTapped()
        }
    }
    
    private func setNotificationsAboutBackgound() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(RecitePoemViewController.onWillResignActive(_:)),
            name: UIApplication.willResignActiveNotification,
            object: nil
        )
    }
}

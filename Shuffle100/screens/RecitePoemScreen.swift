//
//  RecitePoemScreen.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/06/08.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit
import AVFoundation
import Then

final class RecitePoemScreen: SettingsAttachedScreen {
    var recitePoemView: RecitePoemView!
    var gameEndView: AllPoemsRecitedView!
    var currentPlayer: AVAudioPlayer?
    var timerForPrgoress: Timer!
    var playerFinishedAction: (() -> Void)?
    var playButtonTappedAfterFinishedReciting: (() -> Void)?
    var backToPreviousAction: (() -> Void)?
    var skipToNextScreenAction: (() -> Void)?
    var openSettingsAction: (() -> Void)?
    var backToHomeScreenAction: (() -> Void)?
    var startPostMortemAction: (() -> Void)?
    var singer: Singer!
    var playFinished: Bool = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let singerID = settings.singerID
        guard let singer = fetchSinger(id: singerID) else {
            assertionFailure("[\(singerID)]に対応する読手が見つかりません。")
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
        // 自動的にスリープに入るのを防ぐ
        UIApplication.shared.isIdleTimerDisabled = true
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
        // スリープを有効に戻す
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    func addActionsToButtons() {
        if settings.postMortemEnabled {
            recitePoemView.exitButton.tappedAction = {[weak self] in
                self?.selectPosrMortemOrBackToHome()
            }
        } else {
            recitePoemView.exitButton.tappedAction = {[weak self] in
                self?.confirmExittingGame()
            }
        }
        recitePoemView.gearButton.tappedAction = { [weak self] in
            self?.settingsButtonTapped()
        }
        recitePoemView.playButton.tap = { [weak self] btn in
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
            selector: #selector(RecitePoemScreen.onWillResignActive(_:)),
            name: UIApplication.willResignActiveNotification,
            object: nil
        )
    }
}

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
  var playerFinishedAction: InjectedAction?
  var playButtonTappedAfterFinishedReciting: InjectedAction?
  var backToPreviousAction: InjectedAction?
  var skipToNextScreenAction: InjectedAction?
  var openSettingsAction: InjectedAction?
  var backToHomeScreenAction: InjectedAction?
  var startPostMortemAction: InjectedAction?
  var singer: Singer!
  var playFinished: Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    singerSetUp()
    setColorArondNotchArea()
    recitePoemViewSetUp()
    addActionsToButtons()
    setNotificationsAboutBackgound()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.navigationBar.isHidden = true
    // 自動的にスリープに入るのを防ぐ
    UIApplication.shared.isIdleTimerDisabled = true
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    recitePoemView?.fixLayoutOn(baseView: view)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    if let timerForPrgoress = self.timerForPrgoress {
      timerForPrgoress.invalidate()
    }
    if let currentPlayer = currentPlayer {
      if currentPlayer.isPlaying {
        currentPlayer.stop()
      }
    }
    // スリープを有効に戻す
    UIApplication.shared.isIdleTimerDisabled = false
  }
  
  private func singerSetUp() {
    let id = settings.singerID
    guard let singer = Singers.getSingerOfID(id) else {
      assertionFailure("[\(id)]に対応する読手が見つかりません。")
      return
    }
    self.singer = singer
  }
  
  private func setColorArondNotchArea() {
    view.backgroundColor = StandardColor.barTintColor
  }
  
  private func recitePoemViewSetUp() {
    recitePoemView = RecitePoemView()
    view.addSubview(recitePoemView)
    recitePoemView.initView(title: "序歌")
  }
  
  internal func addActionsToButtons() {
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

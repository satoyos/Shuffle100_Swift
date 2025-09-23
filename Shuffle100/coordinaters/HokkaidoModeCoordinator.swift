//
//  HokkaidoModeCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2022/11/22.
//  Copyright © 2022 里 佳史. All rights reserved.
//

import UIKit

final class HokkaidoModeCoordinator: Coordinator, RecitePoemProtocol {
  
  var screen: UIViewController?
  var navigationController: UINavigationController
  internal var settings: Settings
  internal var poemSupplier: PoemSupplier
  internal var store: StoreManager
  var childCoordinator: Coordinator?
  var currentRecitePoemViewModel: RecitePoemViewModel?
  
  init(navigationController: UINavigationController, settings: Settings, store: StoreManager) {
    self.navigationController = navigationController
    self.settings = settings
    self.store = store
    let deck = settings.state100.convertToDeck()
    self.poemSupplier = PoemSupplier(deck: deck, shuffle: true)
    if settings.fakeMode {
      poemSupplier.addFakePoems()
    }
  }
  
  // 強制的に序歌を短くするところが、他のモードと異なる。
  func start() {
    let screen = RecitePoemScreen(settings: settings)
    screen.backToPreviousAction = { [weak self] in
      self?.rewindToPrevious()
    }
    screen.openSettingsAction = { [weak self] in
      self?.openReciteSettings()
    }
    screen.backToHomeScreenAction = { [weak self] in
      self?.backToHomeScreen()
    }
    screen.startPostMortemAction = { [weak self] in
      self?.startPostMortem()
    }
    // 序歌の読み上げは画面遷移が完了したタイミングで開始したいので、
    // CATransanctionを使って、遷移アニメーション完了コールバックを使う。
    CATransaction.begin()
    navigationController.pushViewController(screen, animated: true)
    CATransaction.setCompletionBlock {
      screen.playerFinishedAction = { [weak self] in
        self?.jokaFinished()
      }
      screen.skipToNextScreenAction = { [weak self] in
        self?.jokaFinished()
      }
      screen.loadViewIfNeeded()
      screen.playJoka(shorten: true)
    }
    CATransaction.commit()
    self.screen = screen
  }
  
  // 下の句かるたでは、序歌終了後に他のモードにはない独特の遷移を行う
  func jokaFinished() {
    assert(true, "+++ 北海道モードでの序歌の読み上げ終了!!")
    guard let firstPoem = poemSupplier.drawNextPoem() else { return }
    guard let screen = self.screen as? RecitePoemScreen else { return }
    let number = firstPoem.number
    screen.playerFinishedAction = { [weak self] in
      self?.openWhatsNextScreen()
    }
    screen.skipToNextScreenAction = { [weak self] in
      self?.openWhatsNextScreen()
    }
    screen.stepIntoNextPoem(number: number, at: 1, total: poemSupplier.size)
  }
  
  func reciteKamiFinished(number: Int, counter: Int) {
    assertionFailure(" xxxx 下の句かるたでは、このメソッドは呼ばれてはならない。")
  }
  
  func addKamiScreenActionsForKamiEnding() {
    assertionFailure(" xxxx 下の句かるたでは、このメソッドは呼ばれてはならない。")
  }

  func getCurrentRecitePoemViewModel() -> RecitePoemViewModel? {
    return currentRecitePoemViewModel
  }

  func setCurrentRecitePoemViewModel(_ viewModel: RecitePoemViewModel) {
    self.currentRecitePoemViewModel = viewModel
  }
  
  internal func reciteShimoFinished(number: Int, counter: Int) {
    assert(true, "\(counter)番めの歌(歌番号: \(number))の下の句の読み上げ終了(北海道モード)。")
    guard let screen = self.screen as? RecitePoemScreen else { return }
    if let poem = poemSupplier.drawNextPoem() {
      let number = poem.number
      let counter = poemSupplier.currentIndex
      
      screen.playerFinishedAction = { [weak self] in
        self?.openWhatsNextScreen()
      }
      screen.skipToNextScreenAction = { [weak self] in
        self?.openWhatsNextScreen()
      }
      screen.stepIntoNextPoem(number: number, at: counter, total: poemSupplier.size)
    } else {
      assert(true, "歌は全て読み終えた！")
      screen.stepIntoGameEnd()
    }
  }
  
  internal func goNextPoem() {
    assert(true, "次の詩へ進むボタンが押されたことを、北海道モードのCoordinatorが知ったよ！")
    guard let number = poemSupplier.currentPoem?.number else { return }
    let counter = poemSupplier.currentIndex
    guard let screen = self.screen as? RecitePoemScreen else { return }
    guard counter < poemSupplier.size  else {
      assert(true, "歌は全て読み終えた！")
      screen.stepIntoGameEnd()
      return
    }
    // 次の詩に進むことが決まった後は、読み終えた下の句をもう一度読み上げる
    screen.playerFinishedAction = { [weak self] in
      self?.reciteShimoFinished(number: number, counter: counter)
    }
    screen.skipToNextScreenAction = { [weak self] in
      self?.reciteShimoFinished(number: number, counter: counter)
    }
    refrainShimo()
  }
  
  
  //    ここから下は、できればWhatsNextScreenを使うモード共通の
  //    プロトコル肉繰り出したい。
  
  internal func openWhatsNextScreen() {
    guard let screen = screen else { return }
    guard let currentPoem = poemSupplier.currentPoem else { return }
    let coordinator = WhatsNextCoordinator(
      fromScreen: screen,
      currentPoem: currentPoem,
      settings: settings,
      store: store,
      navigationController: navigationController)
    coordinator.refrainEscalatingAction = { [weak self] in
      self?.refrainShimo()
    }
    coordinator.goNextPoemEscalatingAction = { [weak self] in
      self?.goNextPoem()
    }
    coordinator.exitGameEscalationgAction = { [weak self] in
      self?.exitGame()
    }
    coordinator.start()
    self.childCoordinator = coordinator
  }
  
  internal func refrainShimo() {
    guard let screen = self.screen as? RecitePoemScreen else { return }
    guard let number = poemSupplier.currentPoem?.number else { return }
    let counter = poemSupplier.currentIndex
    screen.refrainShimo(number: number, count: counter)
  }
  
  internal func exitGame() {
    assert(true, "初心者モードのCoordinatorからゲームを終了させるよ！")
    backToHomeScreen()
  }
}

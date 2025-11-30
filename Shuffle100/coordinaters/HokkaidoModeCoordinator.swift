//
//  HokkaidoModeCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2022/11/22.
//  Copyright © 2022 里 佳史. All rights reserved.
//

import UIKit
import SwiftUI

final class HokkaidoModeCoordinator: Coordinator, RecitePoemProtocol {
  
  var screen: UIViewController?
  var navigationController: UINavigationController
  internal var settings: Settings
  internal var poemSupplier: PoemSupplier
  internal var store: StoreManager
  var childCoordinator: Coordinator?
  var whatsNextCoordinator: WhatsNextCoordinator?
  var currentRecitePoemBaseViewModel: RecitePoemBaseViewModel?
  
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
  
  // Note: start()とjokaFinished()は北海道モード固有の処理のためオーバーライド
  // 序歌を強制的に短縮版で再生するため、start()もオーバーライドが必要
  func start() {
    let baseViewModel = RecitePoemBaseViewModel(settings: settings)
    setCurrentRecitePoemBaseViewModel(baseViewModel)

    baseViewModel.recitePoemViewModel.backToPreviousAction = { [weak self] in
      self?.rewindToPrevious()
    }
    baseViewModel.recitePoemViewModel.openSettingsAction = { [weak self] in
      self?.openReciteSettings()
    }
    baseViewModel.recitePoemViewModel.backToHomeScreenAction = { [weak self] in
      self?.backToHomeScreen()
    }
    baseViewModel.recitePoemViewModel.startPostMortemAction = { [weak self] in
      self?.startPostMortem()
    }

    let recitePoemBaseView = RecitePoemBaseView(settings: settings, viewModel: baseViewModel)
    let hostController = ActionAttachedHostingController(
      rootView: recitePoemBaseView
        .environmentObject(ScreenSizeStore.shared)
    )

    // 序歌の読み上げは画面遷移が完了したタイミングで開始したいので、
    // CATransanctionを使って、遷移アニメーション完了コールバックを使う。
    CATransaction.begin()
    navigationController.pushViewController(hostController, animated: true)
    CATransaction.setCompletionBlock {
      baseViewModel.playerFinishedAction = { [weak self] in
        self?.jokaFinished()
      }
      baseViewModel.skipToNextScreenAction = { [weak self] in
        self?.jokaFinished()
      }
      hostController.loadViewIfNeeded()
      baseViewModel.initView(title: "序歌")
      // 北海道モードでは強制的に序歌を短縮版で再生
      baseViewModel.recitePoemViewModel.playJoka(shorten: true)
    }
    CATransaction.commit()
    self.screen = hostController
  }

  func jokaFinished() {
    assert(true, "+++ 北海道モードでの序歌の読み上げ終了!!")
    guard let firstPoem = poemSupplier.drawNextPoem() else { return }

    if let baseViewModel = getCurrentRecitePoemBaseViewModel() {
      let number = firstPoem.number
      // 1首目の下の句終了時は「次はどうする?」画面を表示
      baseViewModel.playerFinishedAction = { [weak self] in
        self?.openWhatsNextScreen()
      }
      baseViewModel.skipToNextScreenAction = { [weak self] in
        self?.openWhatsNextScreen()
      }
      baseViewModel.stepIntoNextPoem(number: number, at: 1, total: poemSupplier.size, side: .shimo)
    } else {
      assertionFailure("Couldn't get baseViewModel")
    }
  }

  func reciteKamiFinished(number: Int, counter: Int) {
    assertionFailure(" xxxx 下の句かるたでは、このメソッドは呼ばれてはならない。")
  }
  
  func addKamiScreenActionsForKamiEnding() {
    assertionFailure(" xxxx 下の句かるたでは、このメソッドは呼ばれてはならない。")
  }

  func getCurrentRecitePoemBaseViewModel() -> RecitePoemBaseViewModel? {
    return currentRecitePoemBaseViewModel
  }

  func setCurrentRecitePoemBaseViewModel(_ viewModel: RecitePoemBaseViewModel) {
    self.currentRecitePoemBaseViewModel = viewModel
  }
  
  internal func reciteShimoFinished(number: Int, counter: Int) {
    assert(true, "\(counter)番めの歌(歌番号: \(number))の下の句の読み上げ終了(北海道モード)。")

    if let baseViewModel = getCurrentRecitePoemBaseViewModel() {
      if let poem = poemSupplier.drawNextPoem() {
        let number = poem.number
        let counter = poemSupplier.currentIndex

        baseViewModel.playerFinishedAction = { [weak self] in
          self?.openWhatsNextScreen()
        }
        baseViewModel.skipToNextScreenAction = { [weak self] in
          self?.openWhatsNextScreen()
        }
        baseViewModel.stepIntoNextPoem(number: number, at: counter, total: poemSupplier.size, side: .shimo)
      } else {
        assert(true, "歌は全て読み終えた！")
        baseViewModel.stepIntoGameEnd()
      }
    } else {
      assertionFailure("Couldn't get baseViewModel")
    }
  }
  
  internal func goNextPoem() {
    assert(true, "次の詩へ進むボタンが押されたことを、北海道モードのCoordinatorが知ったよ！")
    guard let number = poemSupplier.currentPoem?.number else { return }
    let counter = poemSupplier.currentIndex
    guard counter < poemSupplier.size  else {
      assert(true, "歌は全て読み終えた！")
      if let baseViewModel = getCurrentRecitePoemBaseViewModel() {
        baseViewModel.stepIntoGameEnd()
      } else {
        assertionFailure("Couldn't get baseViewModel")
      }
      return
    }
    // 次の詩に進むことが決まった後は、読み終えた下の句をもう一度読み上げる
    if let baseViewModel = getCurrentRecitePoemBaseViewModel() {
      baseViewModel.playerFinishedAction = { [weak self] in
        self?.reciteShimoFinished(number: number, counter: counter)
      }
      baseViewModel.skipToNextScreenAction = { [weak self] in
        self?.reciteShimoFinished(number: number, counter: counter)
      }
    } else {
      assertionFailure("Couldn't get baseViewModel")
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
    self.whatsNextCoordinator = coordinator
    self.childCoordinator = coordinator
  }

  internal func refrainShimo() {
    guard let number = poemSupplier.currentPoem?.number else { return }
    let counter = poemSupplier.currentIndex

    if let baseViewModel = getCurrentRecitePoemBaseViewModel() {
      baseViewModel.refrainShimo(number: number, count: counter)
    } else {
      assertionFailure("Couldn't get baseViewModel")
    }
  }
  
  internal func exitGame() {
    assert(true, "初心者モードのCoordinatorからゲームを終了させるよ！")
    backToHomeScreen()
  }
}

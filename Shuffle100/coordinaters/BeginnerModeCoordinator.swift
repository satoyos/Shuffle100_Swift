//
//  BeginnerModeCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/04/27.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

final class BeginnerModeCoordinator: Coordinator, RecitePoemProtocol {
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
  
  internal func reciteKamiFinished(number: Int, counter: Int) {
    stepIntoShimoInBeginnerMode()
  }
  
  func addKamiScreenActionsForKamiEnding() {
    if let baseViewModel = getCurrentRecitePoemBaseViewModel() {
      baseViewModel.skipToNextScreenAction = { [weak self] in
        self?.stepIntoShimoInBeginnerMode()
      }
    } else {
      assertionFailure("Couldn't get baseViewModel")
    }
  }

  func getCurrentRecitePoemBaseViewModel() -> RecitePoemBaseViewModel? {
    return currentRecitePoemBaseViewModel
  }

  func setCurrentRecitePoemBaseViewModel(_ viewModel: RecitePoemBaseViewModel) {
    self.currentRecitePoemBaseViewModel = viewModel
  }
  
  private func stepIntoShimoInBeginnerMode() {
    guard let number = poemSupplier.currentPoem?.number else { return }
    let counter = poemSupplier.currentIndex

    if let baseViewModel = getCurrentRecitePoemBaseViewModel() {
      baseViewModel.playerFinishedAction = { [weak self] in
        self?.openWhatsNextScreen()
      }
      baseViewModel.skipToNextScreenAction = { [weak self] in
        self?.openWhatsNextScreen()
      }
      baseViewModel.slideIntoShimo(number: number, at: counter, total: poemSupplier.size)
    } else {
      assertionFailure("Couldn't get baseViewModel")
    }
  }
  
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
    assert(true, "下の句を読み返す処理が、BeginnerModeのCoordinatorに戻ってきた！")
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

//
//  BeginnerModeCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/04/27.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

final class BeginnerModeCoordinator: Coordinator, RecitePoemProtocol, WhatsNextSupport {
  var screen: UIViewController?
  var navigationController: UINavigationController
  internal var settings: Settings
  internal var poemSupplier: PoemSupplier
  internal var store: StoreManager
  var childCoordinator: Coordinator?
  var whatsNextCoordinator: WhatsNextCoordinator?  // なぜかWhatsNextCoordinatorが解放されてしまう対策として追加。どうなるか。。。？
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

  // getCurrentRecitePoemBaseViewModel(), setCurrentRecitePoemBaseViewModel() は RecitePoemViewModelHolder プロトコル拡張で提供

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

  // openWhatsNextScreen(), refrainShimo(), exitGame() は WhatsNextSupport プロトコル拡張で提供
}

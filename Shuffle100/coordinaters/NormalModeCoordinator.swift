//
//  NormalModeCoordinator.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/08/07.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

final class NormalModeCoordinator: Coordinator, RecitePoemProtocol {
  var screen: UIViewController?
  var navigationController: UINavigationController
  internal var settings: Settings
  internal var poemSupplier: PoemSupplier
  internal var store: StoreManager
  var childCoordinator: Coordinator?
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
  
  internal func reciteKamiFinished(number: Int, counter: Int ) {
    if let baseViewModel = getCurrentRecitePoemBaseViewModel() {
      // SwiftUI版
      baseViewModel.recitePoemViewModel.showAsWaitingForPlay()
      poemSupplier.stepIntoShimo()
    } else if let screen = self.screen as? RecitePoemScreen {
      // Legacy UIKit版
      screen.waitUserActionAfterFineshdReciing()
      poemSupplier.stepIntoShimo()
    }
  }

  func addKamiScreenActionsForKamiEnding() {
    if let baseViewModel = getCurrentRecitePoemBaseViewModel() {
      // SwiftUI版
      baseViewModel.playButtonTappedAfterFinishedReciting = { [weak self] in
        self?.stepIntoShimoInNormalMode()
      }
      baseViewModel.skipToNextScreenAction = { [weak self] in
        self?.stepIntoShimoInNormalMode()
      }
    } else if let screen = self.screen as? RecitePoemScreen {
      // Legacy UIKit版
      screen.playButtonTappedAfterFinishedReciting = { [weak self] in
        self?.stepIntoShimoInNormalMode()
      }
      screen.skipToNextScreenAction = { [weak self] in
        self?.stepIntoShimoInNormalMode()
      }
    }
  }

  func getCurrentRecitePoemBaseViewModel() -> RecitePoemBaseViewModel? {
    return currentRecitePoemBaseViewModel
  }

  func setCurrentRecitePoemBaseViewModel(_ viewModel: RecitePoemBaseViewModel) {
    self.currentRecitePoemBaseViewModel = viewModel
  }
  
  private func stepIntoShimoInNormalMode() {
    guard let number = poemSupplier.currentPoem?.number else { return }
    let counter = poemSupplier.currentIndex

    if let baseViewModel = getCurrentRecitePoemBaseViewModel() {
      // SwiftUI版
      baseViewModel.playerFinishedAction = { [weak self, number, counter] in
        self?.reciteShimoFinished(number: number, counter: counter)
      }
      baseViewModel.skipToNextScreenAction = { [weak self, number, counter] in
        self?.reciteShimoFinished(number: number, counter: counter)
      }
      poemSupplier.stepIntoShimo()
      baseViewModel.slideIntoShimo(number: number, at: counter, total: poemSupplier.size)
    } else if let screen = self.screen as? RecitePoemScreen {
      // Legacy UIKit版
      screen.playerFinishedAction = { [weak self, number, counter] in
        self?.reciteShimoFinished(number: number, counter: counter)
      }
      screen.skipToNextScreenAction = { [weak self, number, counter] in
        self?.reciteShimoFinished(number: number, counter: counter)
      }
      poemSupplier.stepIntoShimo()
      screen.slideIntoShimo(number: number, at: counter, total: poemSupplier.size)
    }
  }
}

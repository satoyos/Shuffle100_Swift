//
//  NonsotpModeCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/01/29.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

final class NonsotpModeCoordinator: Coordinator, RecitePoemProtocol {
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
  
  internal func reciteKamiFinished(number: Int, counter: Int ) {
    //        print("\(counter)番めの歌(歌番号: \(number))の上の句の読み上げ終了。(ノンストップ)")
    stepIntoShimoInNonstopMode()
  }
  
  func addKamiScreenActionsForKamiEnding() {
    if let viewModel = getCurrentRecitePoemViewModel() {
      // SwiftUI版
      viewModel.skipToNextScreenAction = { [weak self] in
        self?.stepIntoShimoInNonstopMode()
      }
    } else if let screen = self.screen as? RecitePoemScreen {
      // Legacy UIKit版
      screen.skipToNextScreenAction = { [weak self] in
        self?.stepIntoShimoInNonstopMode()
      }
    }
  }

  func getCurrentRecitePoemViewModel() -> RecitePoemViewModel? {
    return currentRecitePoemViewModel
  }

  func setCurrentRecitePoemViewModel(_ viewModel: RecitePoemViewModel) {
    self.currentRecitePoemViewModel = viewModel
  }
  
  private func stepIntoShimoInNonstopMode() {
    assert(true, "ノンストップモードで下の句に突入！")
    guard let number = poemSupplier.currentPoem?.number else { return }
    let counter = poemSupplier.currentIndex

    if let viewModel = getCurrentRecitePoemViewModel() {
      // SwiftUI版
      viewModel.playerFinishedAction = { [weak self, number, counter] in
        self?.reciteShimoFinished(number: number, counter: counter)
      }
      viewModel.skipToNextScreenAction = { [weak self, number, counter] in
        self?.reciteShimoFinished(number: number, counter: counter)
      }
      viewModel.slideIntoShimo(number: number, at: counter, total: poemSupplier.size)
    } else if let screen = self.screen as? RecitePoemScreen {
      // Legacy UIKit版
      screen.playerFinishedAction = { [weak self, number, counter] in
        self?.reciteShimoFinished(number: number, counter: counter)
      }
      screen.skipToNextScreenAction = { [weak self, number, counter] in
        self?.reciteShimoFinished(number: number, counter: counter)
      }
      screen.slideIntoShimo(number: number, at: counter, total: poemSupplier.size)
    }
  }
}

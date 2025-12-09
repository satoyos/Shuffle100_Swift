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
    //        print("\(counter)番めの歌(歌番号: \(number))の上の句の読み上げ終了。(ノンストップ)")
    stepIntoShimoInNonstopMode()
  }
  
  func addKamiScreenActionsForKamiEnding() {
    if let baseViewModel = getCurrentRecitePoemBaseViewModel() {
      baseViewModel.skipToNextScreenAction = { [weak self] in
        self?.stepIntoShimoInNonstopMode()
      }
    } else {
      assertionFailure("Couldn't get baseViewModel")
    }
  }

  // getCurrentRecitePoemBaseViewModel(), setCurrentRecitePoemBaseViewModel() は RecitePoemViewModelHolder プロトコル拡張で提供
  
  private func stepIntoShimoInNonstopMode() {
    assert(true, "ノンストップモードで下の句に突入！")
    guard let number = poemSupplier.currentPoem?.number else { return }
    let counter = poemSupplier.currentIndex

    if let baseViewModel = getCurrentRecitePoemBaseViewModel() {
      baseViewModel.playerFinishedAction = { [weak self, number, counter] in
        self?.reciteShimoFinished(number: number, counter: counter)
      }
      baseViewModel.skipToNextScreenAction = { [weak self, number, counter] in
        self?.reciteShimoFinished(number: number, counter: counter)
      }
      baseViewModel.slideIntoShimo(number: number, at: counter, total: poemSupplier.size)
    } else {
      assertionFailure("Couldn't get baseViewModel")
    }
  }
}

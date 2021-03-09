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

    init(navigationController: UINavigationController, settings: Settings, store: StoreManager) {
        self.navigationController = navigationController
        self.settings = settings
        self.store = store
        let deck = Deck.createFrom(state100: settings.state100)
        self.poemSupplier = PoemSupplier(deck: deck, shuffle: true)
        if settings.fakeMode {
            poemSupplier.addFakePoems()
        }
    }
    
    internal func reciteKamiFinished(number: Int, counter: Int ) {
        guard let screen = self.screen as? RecitePoemScreen else { return }
        screen.waitUserActionAfterFineshdReciing()
        screen.playButtonTappedAfterFinishedReciting = { [weak self] in
            self?.stepIntoShimoInNormalMode()
        }
        screen.skipToNextScreenAction = { [weak self] in
            self?.stepIntoShimoInNormalMode()
        }
        poemSupplier.stepIntoShimo()
    }
  
    private func stepIntoShimoInNormalMode() {
        guard let screen = self.screen as? RecitePoemScreen else { return }
        let number = poemSupplier.poem.number
        let counter = poemSupplier.currentIndex
        screen.playerFinishedAction = { [weak self, number, counter] in
            self?.reciteShimoFinished(number: number, counter: counter)
        }
        screen.slideIntoShimo(number: number, at: counter, total: poemSupplier.size)
    }
}

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
    
    internal func reciteKamiFinished(number: Int, counter: Int) {
        assert(true, "\(counter)番めの歌(歌番号: \(number))の上の句の読み上げ終了。(初心者)")
        stepIntoShimoInBeginnerMode()
    }
    
    private func stepIntoShimoInBeginnerMode() {
        guard let screen = self.screen as? RecitePoemScreen else { return }
        assert(true, "初心者モードで下の句に突入！")
        let number = poemSupplier.poem.number
        let counter = poemSupplier.currentIndex
        screen.playerFinishedAction = { [weak self] in
            self?.openWhatsNextScreen()
        }
        screen.slideIntoShimo(number: number, at: counter, total: poemSupplier.size)
    }
    
    internal func openWhatsNextScreen() {
        guard let screen = screen else { return }
        let coordinator = WhatsNextCoordinator(fromScreen: screen, currentPoem: poemSupplier.poem, settings: settings, store: store)
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
        assert(true, "下の句を読み返す処理が、BeginnerModeのCoordinatorに戻ってきた！")
        guard let screen = self.screen as? RecitePoemScreen else { return }
        let number = poemSupplier.poem.number
        let counter = poemSupplier.currentIndex
        screen.refrainShimo(number: number, count: counter)
    }
    
    internal func exitGame() {
        assert(true, "初心者モードのCoordinatorからゲームを終了させるよ！")
        backToHomeScreen()
    }
}

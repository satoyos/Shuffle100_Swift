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

    init(navigationController: UINavigationController, settings: Settings, store: StoreManager, givenSupplier: PoemSupplier? = nil) {
        self.navigationController = navigationController
        self.settings = settings
        self.store = store
        if let given = givenSupplier {
            self.poemSupplier = given
        } else {
            let deck = Deck.createFrom(state100: settings.state100)
            self.poemSupplier = PoemSupplier(deck: deck, shuffle: true)
            if settings.fakeMode {
                poemSupplier.addFakePoems()
            }
        }
    }
    
    internal func reciteKamiFinished(number: Int, counter: Int ) {
        assert(true, "\(counter)番めの歌(歌番号: \(number))の上の句の読み上げ終了。(ノンストップ)")
        stepIntoShimoInNonstopMode()
    }
    
    private func stepIntoShimoInNonstopMode() {
        assert(true, "ノンストップモードで下の句に突入！")
        let number = poemSupplier.poem.number
        let counter = poemSupplier.currentIndex
        guard let screen = self.screen as? RecitePoemScreen else { return }
        screen.playerFinishedAction = { [weak self, number, counter] in
            self?.reciteShimoFinished(number: number, counter: counter)
        }
        screen.slideIntoShimo(number: number, at: counter, total: poemSupplier.size)
    }
}

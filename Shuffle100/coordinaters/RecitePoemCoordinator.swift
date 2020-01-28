//
//  RecitePoemCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/01/28.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

protocol GameDriver {
    func jokaFinished() -> Void
    func reciteKamiFinished(number: Int, counter: Int) -> Void
    
}

class RecitePoemCoordinator: Coordinator{
    private let navigator: UINavigationController
    private var settings: Settings
    internal var screen: RecitePoemViewController?
    var poemSupplier: PoemSupplier!
    
    init(navigator: UINavigationController, settings: Settings) {
        self.navigator = navigator
        self.settings = settings
        let deck = Deck.create_from(state100: settings.state100)
        self.poemSupplier = PoemSupplier(deck: deck, shuffle: true)
    }
    
    func start() {
        let screen = RecitePoemViewController(settings: settings)

        // 序歌の読み上げは画面遷移が完了したタイミングで開始したいので、
        // CATransanctionを使って、遷移アニメーション完了コールバックを使う。
        CATransaction.begin()
        navigator.pushViewController(screen, animated: true)
        CATransaction.setCompletionBlock {
            screen.playerFinishedAction = { [weak self] in
                self?.jokaFinished()
            }
            screen.playJoka()
        }
        CATransaction.commit()
        self.screen = screen
    }
    
    internal func jokaFinished() {
        assertionFailure("This method must be overridden by subclass")
    }
}

//
//  RecitePoemCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/01/28.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

class RecitePoemCoordinator: Coordinator{
    var screen: UIViewController?
    var navigationController: UINavigationController
    internal var settings: Settings
    internal var poemSupplier: PoemSupplier!
    internal var store: StoreManager
    var childCoordinators = [Coordinator]()

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

    func start() {
        let screen = RecitePoemViewController(settings: settings)
        screen.backToPreviousAction = { [weak self] in
            self?.rewindToPrevious()
        }
        screen.openSettingsAction = { [weak self] in
            self?.openReciteSettings()
        }

        // 序歌の読み上げは画面遷移が完了したタイミングで開始したいので、
        // CATransanctionを使って、遷移アニメーション完了コールバックを使う。
        CATransaction.begin()
        navigationController.pushViewController(screen, animated: true)
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
        assert(true, "序歌の読み上げ終了!!")
        guard let firstPoem = poemSupplier.drawNextPoem() else { return }
        guard let screen = self.screen as? RecitePoemViewController else { return }
        let number = firstPoem.number
        let counter = poemSupplier.currentIndex
        screen.playerFinishedAction = { [weak self, number, counter] in
            self?.reciteKamiFinished(number: number, counter: counter)
        }
        screen.stepIntoNextPoem(number: number, at: counter, total: poemSupplier.size)
    }

    internal func reciteKamiFinished(number: Int, counter: Int ) {
        assertionFailure("This method must be override by subclass!")
    }

    internal func reciteShimoFinished(number: Int, counter: Int) {
        print("\(counter)番めの歌(歌番号: \(number))の下の句の読み上げ終了。")
        guard let screen = self.screen as? RecitePoemViewController else { return }
        if let poem = poemSupplier.drawNextPoem() {
            let number = poem.number
            let counter = poemSupplier.currentIndex
            screen.playerFinishedAction = { [weak self, number, counter] in
                self?.reciteKamiFinished(number: number, counter: counter)
            }
            screen.stepIntoNextPoem(number: number, at: counter, total: poemSupplier.size)

        } else {
            assert(true, "歌は全て読み終えた！")
            screen.stepIntoGameEnd()
        }
    }

    internal func rewindToPrevious() {
        guard let side = poemSupplier.side else {
            assert(true, "序歌の冒頭でrewidが押された")
            backToTopScreen()
            return
        }

        if side == .kami {
            backToPreviousPoem()
        } else {  // 下の句の冒頭でrewindが押された場合
            guard let screen = self.screen as? RecitePoemViewController else { return }
            let number = poemSupplier.poem.number
            let counter = poemSupplier.currentIndex
            let size = poemSupplier.size
            poemSupplier.backToKami()
            screen.slideBackToKami(number: number, at: counter, total: size)
            screen.playerFinishedAction = { [weak self, number, counter] in
                self?.reciteKamiFinished(number: number, counter: counter)
            }
        }
    }

    internal func backToTopScreen() {
        navigationController.popViewController(animated: true)
    }

    private func backToPreviousPoem() {
        if let prevPoem = poemSupplier.rollBackPrevPoem() {
            guard let screen = self.screen as? RecitePoemViewController else { return }
            // 一つ前の歌(prevPoem)に戻す
            let number = prevPoem.number
            let counter = poemSupplier.currentIndex
            screen.playerFinishedAction = { [weak self] in
                self?.reciteShimoFinished(number: number, counter: counter)
            }
            screen.goBackToPrevPoem(number: number, at: counter, total: poemSupplier.size)
        } else {
            // もう戻す歌がない (今が1首め)
            assert(true, "1首目の上の句の冒頭でrewindが押された！")
            backToTopScreen()
        }
    }

    // 歯車ボタンが押されたときの画面遷移をここでやる！
    private func openReciteSettings() {
        guard let screen = self.screen as? RecitePoemViewController else { return }
        let coordinator = ReciteSettingsCoordinator(settings: settings, fromScreen: screen, store: store)
        coordinator.start()
        childCoordinators.append(coordinator)
    }
}

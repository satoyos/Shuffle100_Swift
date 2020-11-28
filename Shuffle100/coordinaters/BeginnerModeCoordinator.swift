//
//  BeginnerModeCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/04/27.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import Foundation

class BeginnerModeCoordinator: RecitePoemCoordinator {
//    var whatsNextCoordinator: WhatsNextCoordinator!
    
    override func reciteKamiFinished(number: Int, counter: Int) {
        assert(true, "\(counter)番めの歌(歌番号: \(number))の上の句の読み上げ終了。(初心者)")
        stepIntoShimoInBeginnerMode()
    }
    
    private func stepIntoShimoInBeginnerMode() {
        guard let screen = self.screen as? RecitePoemViewController else { return }
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
        childCoordinators.append(coordinator)
    }
    
    internal func refrainShimo() {
        assert(true, "下の句を読み返す処理が、BeginnerModeのCoordinatorに戻ってきた！")
        guard let screen = self.screen as? RecitePoemViewController else { return }
        let number = poemSupplier.poem.number
        let counter = poemSupplier.currentIndex
        screen.refrainShimo(number: number, count: counter)
    }
    
    internal func goNextPoem() {
        assert(true, "次の詩へ進むボタンが押されたことを、初心者モードのCoordinatorが知ったよ！")
        let number = poemSupplier.poem.number
        let counter = poemSupplier.currentIndex
        // 次の詩に進むことが決まった後は、Normalモードと同じで、デフォルトの動作をする
        reciteShimoFinished(number: number, counter: counter)
    }
    
    internal func exitGame() {
        assert(true, "初心者モードのCoordinatorからゲームを終了させるよ！")
        backToTopScreen()
    }
}

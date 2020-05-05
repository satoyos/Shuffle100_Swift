//
//  BeginnerModeCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/04/27.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import Foundation

class BeginnerModeCoordinator: RecitePoemCoordinator {
    var whatsNextCoordinator: WhatsNextCoordinator!
    
    override func reciteKamiFinished(number: Int, counter: Int) {
        assert(true, "\(counter)番めの歌(歌番号: \(number))の上の句の読み上げ終了。(初心者)")
        stepIntoShimoInBeginnerMode()
    }
    
    private func stepIntoShimoInBeginnerMode() {
        guard let screen = screen else { return }
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
        let coordinator = WhatsNextCoordinator(fromScreen: screen, currentPoem: poemSupplier.poem)
        coordinator.start()
        self.whatsNextCoordinator = coordinator
    }
}

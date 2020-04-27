//
//  BeginnerModeCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/04/27.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import Foundation

class BeginnerModeCoordinator: RecitePoemCoordinator {
    override func reciteKamiFinished(number: Int, counter: Int) {
        assert(true, "\(counter)番めの歌(歌番号: \(number))の上の句の読み上げ終了。(初心者)")
        stepIntoShimoInBeginnerMode()
    }
    
    private func stepIntoShimoInBeginnerMode() {
        guard let screen = screen else { return }
        assert(true, "初心者モードで下の句に突入！")
        let number = poemSupplier.poem.number
        let counter = poemSupplier.currentIndex
        screen.playerFinishedAction = { [weak self, number, counter] in
            self?.reciteShimoFinished(number: number, counter: counter)
        }
        screen.slideIntoShimo(number: number, at: counter, total: poemSupplier.size)
    }
}

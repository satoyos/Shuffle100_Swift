//
//  NonsotpModeCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/01/29.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

class NonsotpModeCoordinator: RecitePoemCoordinator {

    override internal func reciteKamiFinished(number: Int, counter: Int ) {
        assert(true, "\(counter)番めの歌(歌番号: \(number))の上の句の読み上げ終了。(ノンストップ)")
        stepIntoShimoInNonstopMode()
    }
    
    private func stepIntoShimoInNonstopMode() {
        assert(true, "ノンストップモードで下の句に突入！")
        let number = poemSupplier.poem.number
        let counter = poemSupplier.currentIndex
        screen!.playerFinishedAction = { [weak self, number, counter] in
            self?.reciteShimoFinished(number: number, counter: counter)
        }
        screen?.slideIntoShimo(number: number, at: counter, total: poemSupplier.size)
    }
}

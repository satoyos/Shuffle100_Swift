//
//  NormalModeCoordinator.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/08/07.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

final class NormalModeCoordinator: RecitePoemCoordinator {

    override internal func reciteKamiFinished(number: Int, counter: Int ) {
        guard let screen = self.screen as? RecitePoemViewController else { return }
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
        guard let screen = self.screen as? RecitePoemViewController else { return }
        let number = poemSupplier.poem.number
        let counter = poemSupplier.currentIndex
        screen.playerFinishedAction = { [weak self, number, counter] in
            self?.reciteShimoFinished(number: number, counter: counter)
        }
        screen.slideIntoShimo(number: number, at: counter, total: poemSupplier.size)
    }
}

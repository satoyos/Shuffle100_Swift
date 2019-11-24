//
//  RecitePoemCoordinator.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/08/07.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

final class RecitePoemCoordinator: Coordinator {
    private let navigator: UINavigationController
    private var settings: Settings
    private var screen: RecitePoemViewController?
    var poemSupplier: PoemSupplier!
    
    init(navigator: UINavigationController, settings: Settings) {
        self.navigator = navigator
        self.settings = settings
        let deck = Deck.create_from(state100: settings.state100)
        self.poemSupplier = PoemSupplier(deck: deck, shuffle: false)
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
    
    private func jokaFinished() {
        print("序歌の読み上げ終了!!")
        _ = poemSupplier.draw_next_poem()
        let number = poemSupplier.poem.number
        let counter = poemSupplier.current_index
        screen!.playerFinishedAction = { [weak self, number, counter] in
            self?.reciteKamiFinished(number: number, counter: counter)
        }
        screen!.stepIntoNextPoem(number: number, at: counter, total: poemSupplier.size)
    }
    
    private func reciteKamiFinished(number: Int, counter: Int ) {
        print("\(counter)番めの歌(歌番号: \(number))の上の句の読み上げ終了。")
    }
  
}

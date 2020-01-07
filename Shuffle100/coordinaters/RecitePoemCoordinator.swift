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
    
    private func jokaFinished() {
        print("序歌の読み上げ終了!!")
        guard let firstPoem = poemSupplier.drawNextPoem() else { return }
        let number = firstPoem.number
        let counter = poemSupplier.currentIndex
        screen!.playerFinishedAction = { [weak self, number, counter] in
            self?.reciteKamiFinished(number: number, counter: counter)
        }
        screen!.stepIntoNextPoem(number: number, at: counter, total: poemSupplier.size)
    }
    
    private func reciteKamiFinished(number: Int, counter: Int ) {
        print("\(counter)番めの歌(歌番号: \(number))の上の句の読み上げ終了。")
        guard let screen = screen else { return }
        screen.waitUserActionAfterFineshdReciing()
        screen.playButtonTappedAfterFinishedReciting = { [weak self] in
            self?.stepIntoShimoInNormalMode()
        }
    }
  
    private func stepIntoShimoInNormalMode() {
        print("上の句が終わった状態でPlayButtonが押された！")
        let number = poemSupplier.poem.number
        let counter = poemSupplier.currentIndex
        screen!.playerFinishedAction = { [weak self, number, counter] in
            self?.reciteShimoFinished(number: number, counter: counter)
        }
        screen?.slideIntoShimo(number: number, at: counter, total: poemSupplier.size)
    }
    
    private func reciteShimoFinished(number: Int, counter: Int) {
        print("\(counter)番めの歌(歌番号: \(number))の下の句の読み上げ終了。")
        if let poem = poemSupplier.drawNextPoem() {
            let number = poem.number
            let counter = poemSupplier.currentIndex
            screen!.playerFinishedAction = { [weak self, number, counter] in
                self?.reciteKamiFinished(number: number, counter: counter)
            }
            screen!.stepIntoNextPoem(number: number, at: counter, total: poemSupplier.size)
        
        } else {
            print("歌は全て読み終えた！")
            screen!.stepIntoGameEnd()
        }
    }
}

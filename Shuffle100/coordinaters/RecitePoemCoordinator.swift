//
//  RecitePoemCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/01/28.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

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
        screen.backToPreviousAction = { [weak self] in
            self?.rewindToPrevious()
        }
        
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
        print("序歌の読み上げ終了!!")
        guard let firstPoem = poemSupplier.drawNextPoem() else { return }
        let number = firstPoem.number
        let counter = poemSupplier.currentIndex
        screen!.playerFinishedAction = { [weak self, number, counter] in
            self?.reciteKamiFinished(number: number, counter: counter)
        }
        screen!.stepIntoNextPoem(number: number, at: counter, total: poemSupplier.size)
    }
    
    internal func reciteKamiFinished(number: Int, counter: Int ) {
        assertionFailure("This method must be override by subclass!")
    }
    
    internal func reciteShimoFinished(number: Int, counter: Int) {
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
    
    internal func rewindToPrevious() {
        print("!! 歌の読み上げ冒頭でrewindボタンが押されたので、一つ前の画面に戻す！")
        if poemSupplier.currentIndex == 0 {
            navigator.popViewController(animated: true)
        } else {
            if let prevPoem = poemSupplier.rollBackPrevPoem() {
                // 一つ前の歌(prevPoem)に戻す
                assertionFailure("ここはまだ未実装")
            } else {
                // もう戻す歌がない (今が1首め)
                navigator.popViewController(animated: true)
            }
        }
    }
}

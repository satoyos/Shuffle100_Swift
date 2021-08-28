//
//  RecitePoemProtocol.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/01/28.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

protocol RecitePoemProtocol: BackToHome {
    var settings: Settings { get set }
    var store: StoreManager { get set }
    var poemSupplier: PoemSupplier { get set }
    
    mutating func jokaFinished() -> Void
    mutating func reciteKamiFinished(number: Int, counter: Int ) -> Void
    mutating func reciteShimoFinished(number: Int, counter: Int) -> Void
    mutating func goNextPoem() -> Void
    mutating func startPostMortem() -> Void
    func addKamiScreenActions()
}

extension RecitePoemProtocol where Self: Coordinator {
    
    func start() {
        let screen = RecitePoemScreen(settings: settings)
        screen.backToPreviousAction = { [weak self] in
            self?.rewindToPrevious()
        }
        screen.openSettingsAction = { [weak self] in
            self?.openReciteSettings()
        }
        screen.backToHomeScreenAction = { [weak self] in
            self?.backToHomeScreen()
        }
        screen.startPostMortemAction = { [weak self] in
            self?.startPostMortem()
        }
        // 序歌の読み上げは画面遷移が完了したタイミングで開始したいので、
        // CATransanctionを使って、遷移アニメーション完了コールバックを使う。
        CATransaction.begin()
        navigationController.pushViewController(screen, animated: true)
        let shorten = settings.shortenJoka
        CATransaction.setCompletionBlock {
            screen.playerFinishedAction = { [weak self] in
                self?.jokaFinished()
            }
            screen.playJoka(shorten: shorten)
        }
        CATransaction.commit()
        self.screen = screen
    }
    
    func addKamiScreenActions() {
        // default: Do nothing
    }
    
    mutating func jokaFinished() {
        assert(true, "序歌の読み上げ終了!!")
        guard let firstPoem = poemSupplier.drawNextPoem() else { return }
        guard let screen = self.screen as? RecitePoemScreen else { return }
        let number = firstPoem.number
        let counter = poemSupplier.currentIndex
        screen.playerFinishedAction = { [weak self, number, counter] in
            self?.reciteKamiFinished(number: number, counter: counter)
        }
        addKamiScreenActions()
        screen.stepIntoNextPoem(number: number, at: counter, total: poemSupplier.size)
    }
    
    mutating func reciteShimoFinished(number: Int, counter: Int) {
        assert(true, "\(counter)番めの歌(歌番号: \(number))の下の句の読み上げ終了。")
        guard let screen = self.screen as? RecitePoemScreen else { return }
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
    
    internal mutating func rewindToPrevious() {
        guard let side = poemSupplier.side else {
            assert(true, "序歌の冒頭でrewidが押された")
            backToHomeScreen()
            return
        }

        if side == .kami {
            backToPreviousPoem()
        } else {  // 下の句の冒頭でrewindが押された場合
            guard let screen = self.screen as? RecitePoemScreen else { return }
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
    
    internal mutating func goNextPoem() {
        assert(true, "次の詩へ進むボタンが押されたことを、初心者モードのCoordinatorが知ったよ！")
        let number = poemSupplier.poem.number
        let counter = poemSupplier.currentIndex
        // 次の詩に進むことが決まった後は、Normalモードと同じで、デフォルトの動作をする
        reciteShimoFinished(number: number, counter: counter)
    }
    
    internal mutating func startPostMortem() {
        print("!! Coordinatorから感想戦を始めますよ！!")
        poemSupplier.resetCurrentIndex()
        self.start()
    }
    
    // 歯車ボタンが押されたときの画面遷移をここでやる！
    private func openReciteSettings() {
        guard let screen = self.screen as? RecitePoemScreen else { return }
        let coordinator = ReciteSettingsCoordinator(settings: settings, fromScreen: screen, store: store)
        coordinator.start()
        self.childCoordinator = coordinator
    }
    
    private mutating func backToPreviousPoem() {
        if let prevPoem = poemSupplier.rollBackPrevPoem() {
            guard let screen = self.screen as? RecitePoemScreen else { return }
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
            backToHomeScreen()
        }
    }
}

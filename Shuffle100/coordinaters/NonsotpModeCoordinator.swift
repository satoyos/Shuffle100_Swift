//
//  NonsotpModeCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/01/29.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

class NonsotpModeCoordinator: RecitePoemCoordinator {

//    //
//    // 問題なければ、このメソッドはSuper classいに移す！
//    //
//    override internal func jokaFinished() {
//        print("序歌の読み上げ終了!!")
//        guard let firstPoem = poemSupplier.drawNextPoem() else { return }
//        let number = firstPoem.number
//        let counter = poemSupplier.currentIndex
//        screen!.playerFinishedAction = { [weak self, number, counter] in
//            self?.reciteKamiFinished(number: number, counter: counter)
//        }
//        screen!.stepIntoNextPoem(number: number, at: counter, total: poemSupplier.size)
//    }
    
    override internal func reciteKamiFinished(number: Int, counter: Int ) {
        print("\(counter)番めの歌(歌番号: \(number))の上の句の読み上げ終了。(ノンストップ)")
        stepIntoShimoInNonstopMode()
    }
    
    private func stepIntoShimoInNonstopMode() {
        print("ノンストップモードで下の句に突入！")
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

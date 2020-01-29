//
//  NormalModeCoordinator.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/08/07.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

final class NormalModeCoordinator: RecitePoemCoordinator {

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

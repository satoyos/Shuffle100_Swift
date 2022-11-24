//
//  HokkaidoModeCoordinator.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2022/11/22.
//  Copyright © 2022 里 佳史. All rights reserved.
//

import UIKit

final class HokkaidoModeCoordinator: Coordinator, RecitePoemProtocol {

    var screen: UIViewController?
    var navigationController: UINavigationController
    internal var settings: Settings
    internal var poemSupplier: PoemSupplier
    internal var store: StoreManager
    var childCoordinator: Coordinator?
    
    init(navigationController: UINavigationController, settings: Settings, store: StoreManager) {
        self.navigationController = navigationController
        self.settings = settings
        self.store = store
        let deck = Poem100.createFrom(state100: settings.state100)
        self.poemSupplier = PoemSupplier(deck: deck, shuffle: true)
        if settings.fakeMode {
            poemSupplier.addFakePoems()
        }
    }
    
    // 下の句かるたでは、序歌終了後に他のモードにはない独特の遷移を行う
    func jokaFinished() {
        assert(true, "+++ 北海道モードでの序歌の読み上げ終了!!")
        guard let firstPoem = poemSupplier.drawNextPoem() else { return }
        guard let screen = self.screen as? RecitePoemScreen else { return }
        let number = firstPoem.number
        screen.playerFinishedAction = { [weak self, number] in
            self?.reciteShimoFinished(number: number, counter: 1)  // 序歌を読み上げたばかりなので、counterは1首目確定
        }
        screen.stepIntoNextPoem(number: number, at: 1, total: poemSupplier.size)
    }
    
    func reciteKamiFinished(number: Int, counter: Int) {
        assertionFailure(" xxxx 下の句かるたでは、このメソッドは呼ばれてはならない。")
    }
    
    func addKamiScreenActionsForKamiEnding() {
        assertionFailure(" xxxx 下の句かるたでは、このメソッドは呼ばれてはならない。")
    }
    

}

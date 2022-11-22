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
    
    func reciteKamiFinished(number: Int, counter: Int) {
        // to be implemented
    }
    
    func addKamiScreenActionsForKamiEnding() {
        // to be implemented
    }
    

}

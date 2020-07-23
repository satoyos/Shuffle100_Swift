//
//  PoemPickerCoordinator.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/08/04.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

final class PoemPickerCoordinator: Coordinator {
    private let navigator: UINavigationController
    private var settings: Settings
    internal var screen: UIViewController?
    private var store: StoreManager
    private var ngramPickerCoordinator: NgramPickerCoordinator!
    private var fudaSetsCoordinator: FudaSetsCoordinator!
    
    init(navigator: UINavigationController, settings: Settings, store: StoreManager) {
        self.navigator = navigator
        self.settings = settings
        self.store = store
    }
    
    func start() {
        let screen = PoemPickerViewController(settings: settings)
        screen.saveSettingsAction = { [store, settings] in
            print("<Save> 選んだ歌のデータをセーブするよ！")
            do {
                try store.save(value: settings, key: Settings.userDefaultKey)
            } catch {
                assertionFailure("SttingsデータのUserDefautへの保存に失敗しました。")
            }
        }
        screen.openNgramPickerAction = { [weak self] in
            self?.openNgramPicker()
        }
        screen.openFudaSetsScreenAction = { [weak self] in
            self?.openFudaSetsScreen()
        }
        screen.showTorifudaAction = { [weak self] indexPath  in
            self?.showTorifudaScreenFor(indexPath)
        }
        navigator.pushViewController(screen, animated: true)
        self.screen = screen
    }
    
    internal func openNgramPicker() {
        let coordinator = NgramPickerCoordinator(navigator: navigator, settings: settings, store: store)
        coordinator.start()
        self.ngramPickerCoordinator = coordinator
    }
    
    internal func openFudaSetsScreen() {
        let coordinator = FudaSetsCoordinator(navigator: navigator, settings: settings, store: store)
        coordinator.start()
        self.fudaSetsCoordinator = coordinator
    }
    
    internal func showTorifudaScreenFor(_ indexPath: IndexPath) {
        let poem = Deck.originalPoems[indexPath.row]
        let shimoStr = poem.in_hiragana.shimo
        var title = "\(poem.number)."
        for partStr in poem.liner {
            title += " \(partStr)"
        }
        let fudaScreen = FudaViewController(shimoString: shimoStr, title: title)
        let nav = UINavigationController(rootViewController: fudaScreen)
        nav.modalPresentationStyle = .fullScreen
        nav.navigationBar.barTintColor = StandardColor.barTintColor
        screen?.present(nav, animated: true)
    }
}

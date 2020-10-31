//
//  PoemPickerCoordinator.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/08/04.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

final class PoemPickerCoordinator: Coordinator, SaveSettings, HandleNavigator {
    internal var settings: Settings?
    internal var store: StoreManager?
    private let navigator: UINavigationController
    internal var screen: UIViewController?
    private var ngramPickerCoordinator: NgramPickerCoordinator!
    private var fudaSetsCoordinator: FudaSetsCoordinator!
    private var fiveColorsCoordinator: FiveColorsCoordinator!
    
    init(navigator: UINavigationController, settings: Settings, store: StoreManager) {
        self.navigator = navigator
        self.settings = settings
        self.store = store
    }
    
    func start() {
        guard let settings = settings else { return }
        guard let store = store else { return }
        let screen = PoemPickerViewController(settings: settings)
        screen.saveSettingsAction = { [store, settings] in
            self.saveSettingsPermanently(settings, into: store)
        }
        screen.openNgramPickerAction = { [weak self] in
            self?.openNgramPicker()
        }
        screen.openFudaSetsScreenAction = { [weak self] in
            self?.openFudaSetsScreen()
        }
        screen.openFiveColorsScreenAction = { [weak self] in
            self?.openFiveColorsScreen()
        }
        screen.showTorifudaAction = { [weak self] number in
            self?.showTorifudaScreenFor(number: number)
        }
        navigator.pushViewController(screen, animated: true)
        screen.navigationItem.prompt = navigationItemPrompt()
        self.screen = screen
    }
    
    internal func openNgramPicker() {
        guard let settings = settings else { return }
        guard let store = store else { return }
        let coordinator = NgramPickerCoordinator(navigator: navigator, settings: settings, store: store)
        coordinator.start()
        self.ngramPickerCoordinator = coordinator
    }
    
    internal func openFudaSetsScreen() {
        guard let settings = settings else { return }
        guard let store = store else { return }
        let coordinator = FudaSetsCoordinator(navigator: navigator, settings: settings, store: store)
        coordinator.start()
        self.fudaSetsCoordinator = coordinator
    }
    
    internal func openFiveColorsScreen() {
        guard let settings = settings else { return }
        guard let store = store else { return }
        let coordinator = FiveColorsCoordinator(navigator: navigator, settings: settings, store: store)
        coordinator.start()
        self.fiveColorsCoordinator = coordinator
    }
    
    internal func showTorifudaScreenFor(number: Int) {
        let poem = Deck.originalPoems[number-1]
        let shimoStr = poem.in_hiragana.shimo
        var title = "\(poem.number)."
        for partStr in poem.liner {
            title += " \(partStr)"
        }
        let fudaScreen = FudaViewController(shimoString: shimoStr, title: title, fullLiner: poem.liner)
        let nav = UINavigationController(rootViewController: fudaScreen)
        nav.modalPresentationStyle = .fullScreen
        nav.navigationBar.barTintColor = StandardColor.barTintColor
        screen?.present(nav, animated: true)
    }
}

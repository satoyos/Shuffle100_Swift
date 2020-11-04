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
    private var torifudaCoordinator: TorifudaCoordinator!
    
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
        clearSearchResult()
        let coordinator = NgramPickerCoordinator(navigator: navigator, settings: settings, store: store)
        coordinator.start()
        self.ngramPickerCoordinator = coordinator
    }
    
    internal func openFudaSetsScreen() {
        guard let settings = settings else { return }
        guard let store = store else { return }
        clearSearchResult()
        let coordinator = FudaSetsCoordinator(navigator: navigator, settings: settings, store: store)
        coordinator.start()
        self.fudaSetsCoordinator = coordinator
    }
    
    internal func openFiveColorsScreen() {
        guard let settings = settings else { return }
        guard let store = store else { return }
        clearSearchResult()
        let coordinator = FiveColorsCoordinator(navigator: navigator, settings: settings, store: store)
        coordinator.start()
        self.fiveColorsCoordinator = coordinator
    }
    
    internal func showTorifudaScreenFor(number: Int) {
        let poem = Deck.originalPoems[number-1]
        let coordinator = TorifudaCoordinator(navigator: navigator, poem: poem)
        coordinator.start()
        self.torifudaCoordinator = coordinator
    }
    
    private func clearSearchResult() {
        if let screen = screen as? PoemPickerViewController {
            screen.searchController.searchBar.text = ""
        }
    }
}

//
//  PoemPickerCoordinator.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/08/04.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

final class PoemPickerCoordinator: Coordinator, SaveSettings, HandleNavigator {

    internal var settings: Settings
    internal var store: StoreManager
    var navigationController: UINavigationController
    var screen: UIViewController?
    var childCoordinator: Coordinator?

    init(navigationController: UINavigationController, settings: Settings, store: StoreManager) {
        self.navigationController = navigationController
        self.settings = settings
        self.store = store
    }

    func start() {
        let screen = PoemPickerScreen(settings: settings)
        screen.saveSettingsAction = { [store, settings, weak self] in
            self?.saveSettingsPermanently(settings, into: store)
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
        screen.openDigitsPicker01Action = { [weak self] in
            self?.openDigitsPickerScreen01()
        }
        screen.openDigitsPicker10Action = { [weak self] in
            self?.openDigitsPickerScreen10()
        }
        screen.showTorifudaAction = { [weak self] number in
            self?.showTorifudaScreenFor(number: number)
        }
        screen.viewDidAppearAction = { [weak self] in
            self?.childCoordinator = nil
        }
        navigationController.pushViewController(screen, animated: true)
        screen.navigationItem.prompt = navigationItemPrompt
        self.screen = screen
    }

    internal func openNgramPicker() {
        clearSearchResult()
        let coordinator = NgramPickerCoordinator(navigationController: navigationController, settings: settings, store: store)
        coordinator.start()
        self.childCoordinator = coordinator
    }

    internal func openFudaSetsScreen() {
        clearSearchResult()
        let coordinator = FudaSetsCoordinator(navigationController: navigationController, settings: settings, store: store)
        coordinator.start()
        self.childCoordinator = coordinator
    }

    internal func openFiveColorsScreen() {
        clearSearchResult()
        let coordinator = FiveColorsCoordinator(navigationController: navigationController, settings: settings, store: store)
        coordinator.start()
        self.childCoordinator = coordinator
    }

    internal func openDigitsPickerScreen01() {
        clearSearchResult()
        let coordinator = DigitsPickerScreen01Coordinator(navigationController: navigationController, settings: settings, store: store)
        coordinator.start()
        self.childCoordinator = coordinator
    }
    
    internal func openDigitsPickerScreen10() {
        clearSearchResult()
        let coordinator = DigitsPickerScreen10Coordinator(navigationController: navigationController, settings: settings, store: store)
        coordinator.start()
        self.childCoordinator = coordinator
    }

    internal func showTorifudaScreenFor(number: Int) {
        let poem = Poem100.originalPoems[number-1]
        let coordinator = TorifudaCoordinator(navigationController: navigationController, poem: poem)
        coordinator.start()
        self.childCoordinator = coordinator
    }

    private func clearSearchResult() {
        if let screen = screen as? PoemPickerScreen {
            screen.searchController.searchBar.text = ""
        }
    }
}

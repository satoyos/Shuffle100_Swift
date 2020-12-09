//
//  MainCoordinator.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/04/21.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator, SaveSettings, HandleNavigator {
    internal var settings: Settings
    internal var store: StoreManager
    internal var screen: UIViewController?
    var navigationController: UINavigationController
    static let env = Environment()
    var childCoordinators = [Coordinator]()

    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        let store = StoreManager()
        self.settings = Self.setUpSettings(store: store)
        self.store = StoreManager()
    }

    func start() {
//        let store = StoreManager()
//        self.store = store
//        let settings = setUpSettings()
//        self.settings = settings
        let homeScreen = HomeViewController(settings: settings)
        self.screen = homeScreen
        navigationController.pushViewController(homeScreen, animated: false)
        setUpNavigationController(navigationController)
        setActions(in: homeScreen, settings: settings, store: store, navigator: navigationController)
        AudioPlayerFactory.shared.setupAudioSession()
    }

    private func setActions(in homeScreen: HomeViewController, settings: Settings, store: StoreManager, navigator: UINavigationController) {
        homeScreen.selectPoemAction = {[weak self, unowned settings, store] in
            self?.selectPoem(settings: settings, store: store)
        }
        homeScreen.selectModeAction = {[weak self, unowned settings, store] in
            self?.selectMode(settings: settings, store: store)
        }
        homeScreen.selectSingerAction = {[weak self, unowned settings, store] in
            self?.selectSinger(settings: settings, store: store)
        }
        homeScreen.startGameAction = {[weak self, unowned settings, store] in
            self?.startGame(settings: settings, store: store)
        }
        homeScreen.reciteSettingsAction = { [weak self, unowned settings, store] in
            self?.openReciteSettings(from: homeScreen, settins: settings, store: store)
        }
        homeScreen.helpActioh = { [weak self] in
            self?.openHelpList()
        }
        homeScreen.memorizeTimerAction = { [weak self] in
            self?.openMemorizeTimer()
        }
        setSaveSettingsActionTo(screen: homeScreen, settings: settings, store: store)
    }

    private func selectPoem(settings: Settings, store: StoreManager) {
        let coordinator = PoemPickerCoordinator(navigationController: navigationController, settings: settings, store: store)
        coordinator.start()
        childCoordinators.append(coordinator)
    }

    private func selectMode(settings: Settings, store: StoreManager) {
        let coordinator = SelectModeCoordinator(navigationController: navigationController, settings: settings, store: store)
        coordinator.start()
        childCoordinators.append(coordinator)
    }

    private func selectSinger(settings: Settings, store: StoreManager) {
        let coordinator = SelectSingerCoordinator(navigationController: navigationController, settings: settings, store: store)
        coordinator.start()
        childCoordinators.append(coordinator)
    }

    private func startGame(settings: Settings, store: StoreManager) {
        var gameDriver: RecitePoemCoordinator!

        switch settings.mode.reciteMode {
        case .normal:
            gameDriver = NormalModeCoordinator(navigationController: navigationController, settings: settings, store: store)
            gameDriver.start()
        case .nonstop:
            gameDriver = NonsotpModeCoordinator(navigationController: navigationController, settings: settings, store: store)
            gameDriver.start()
        case .beginner:
            gameDriver = BeginnerModeCoordinator(navigationController: navigationController, settings: settings, store: store)
            gameDriver.start()
        }
        guard let coordinator = gameDriver else { return }
        childCoordinators.append(coordinator)
    }

    private func setSaveSettingsActionTo(screen: HomeViewController, settings: Settings, store: StoreManager) {
        screen.saveSettingsAction = { [store, settings] in
            self.saveSettingsPermanently(settings, into: store)
        }
    }

    private func openReciteSettings(from screen: UIViewController, settins: Settings, store: StoreManager) {
        let coordinator = ReciteSettingsCoordinator(settings: settins, fromScreen: screen, store: store)
        coordinator.start()
        childCoordinators.append(coordinator)
    }

    private func openHelpList() {
        let coordinator = HelpListCoordinator(navigationController: navigationController)
        coordinator.start()
        childCoordinators.append(coordinator)
    }

    private func openMemorizeTimer() {
        let coordinator = MemorizeTimerCoordinator(navigationController: navigationController)
        coordinator.start()
        childCoordinators.append(coordinator)
    }
}

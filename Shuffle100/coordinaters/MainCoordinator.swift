//
//  MainCoordinator.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/04/21.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

final class MainCoordinator: NSObject, Coordinator, SaveSettings, HandleNavigator, UINavigationControllerDelegate {

    internal var settings: Settings
    internal var store: StoreManager
    internal var screen: UIViewController?
    var navigationController: UINavigationController
    static let env = Environment()
    var childCoordinator: Coordinator?

    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        let store = StoreManager()
        self.settings = Self.setUpSettings(store: store)
//        self.store = StoreManager()
        self.store = store
    }

    func start() {
        let homeScreen = HomeScreen(settings: settings)
        self.screen = homeScreen
        navigationController.pushViewController(homeScreen, animated: false)
        setUpNavigationController(navigationController)
        navigationController.delegate = self
        setActions(in: homeScreen, settings: settings, store: store, navigator: navigationController)
        AudioPlayerFactory.shared.setupAudioSession()
    }

    private func setActions(in homeScreen: HomeScreen, settings: Settings, store: StoreManager, navigator: UINavigationController) {
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
        homeScreen.viewDidAppearAction = { [weak self] in
            self?.childCoordinator = nil
        }
        setSaveSettingsActionTo(screen: homeScreen, settings: settings, store: store)
    }

    private func selectPoem(settings: Settings, store: StoreManager) {
        let coordinator = PoemPickerCoordinator(navigationController: navigationController, settings: settings, store: store)
        coordinator.start()
        self.childCoordinator = coordinator
    }

    private func selectMode(settings: Settings, store: StoreManager) {
        let coordinator = SelectModeCoordinator(navigationController: navigationController, settings: settings, store: store)
        coordinator.start()
        self.childCoordinator = coordinator
    }

    private func selectSinger(settings: Settings, store: StoreManager) {
        let coordinator = SelectSingerCoordinator(navigationController: navigationController, settings: settings, store: store)
        coordinator.start()
        self.childCoordinator = coordinator
    }

    private func startGame(settings: Settings, store: StoreManager) {
        var gameDriver: Coordinator!

        switch settings.reciteMode {
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
        self.childCoordinator = coordinator
    }

    private func setSaveSettingsActionTo(screen: SettingsAttachedScreen, settings: Settings, store: StoreManager) {
        screen.saveSettingsAction = { [store, settings, weak self] in
            self?.saveSettingsPermanently(settings, into: store)
        }
    }

    private func openReciteSettings(from screen: UIViewController, settins: Settings, store: StoreManager) {
        let coordinator = ReciteSettingsCoordinator(settings: settins, fromScreen: screen, store: store)
        coordinator.start()
        self.childCoordinator = coordinator
    }

    private func openHelpList() {
        let coordinator = HelpListCoordinator(navigationController: navigationController)
        coordinator.start()
        self.childCoordinator = coordinator
    }

    private func openMemorizeTimer() {
        let coordinator = MemorizeTimerCoordinator(navigationController: navigationController)
        coordinator.start()
        self.childCoordinator = coordinator
    }
}

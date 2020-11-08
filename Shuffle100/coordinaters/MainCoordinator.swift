//
//  MainCoordinator.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/04/21.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator, SaveSettings, HandleNavigator {
    private let window: UIWindow
    internal var store: StoreManager?
    internal var screen: UIViewController?
    private var navigator: UINavigationController?
    internal var settings: Settings?
    internal let env = Environment()
    private var recitePoemCoordinator: RecitePoemCoordinator!
    private var reciteSettingsCoordinator: ReciteSettingsCoordinator!
    private var poemPickerCoordinator: PoemPickerCoordinator!
    private var helpListCoordinator: HelpListCoordinator!
    private var memorizeTimerCoordinator: MemorizeTimerCoordinator!

    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        self.store = StoreManager()
        self.settings = setUpSettings()
        guard let settings = settings else { return }
        let homeScreen = HomeViewController(settings: settings)
        self.screen = homeScreen
        let navigator = UINavigationController(rootViewController: homeScreen)
        setUpNavigationController(navigator)
        self.navigator = navigator
        
        window.rootViewController = navigator
        window.makeKeyAndVisible()

        homeScreen.selectPoemAction = {[weak self, unowned settings] in
            self?.selectPoem(settings: settings)
        }
        homeScreen.selectModeAction = {[weak self, unowned settings] in
            self?.selectMode(settings: settings)
        }
        homeScreen.selectSingerAction = {[weak self, unowned settings] in
            self?.selectSinger(settings: settings)
        }
        homeScreen.startGameAction = {[weak self, unowned settings] in
            self?.startGame(settings: settings)
        }
        homeScreen.reciteSettingsAction = { [weak self, unowned settings] in
            self?.openReciteSettings(settins: settings)
        }
        homeScreen.helpActioh = { [weak self] in
            self?.openHelpList()
        }
        homeScreen.memorizeTimerAction = { [weak self] in
            self?.openMemorizeTimer()
        }
        setSaveSettingsActionTo(screen: homeScreen, settings: settings)
        AudioPlayerFactory.shared.setupAudioSession()
//        self.screen = homeScreen
    }
    
    private func selectPoem(settings: Settings) {
        guard let store = store else { return }
        guard let navigator = navigator else { return }
        let coordinator = PoemPickerCoordinator(navigator: navigator, settings: settings, store: store)
        coordinator.start()
        self.poemPickerCoordinator = coordinator
    }
    
    private func selectMode(settings: Settings) {
        guard let store = store else { return }
        guard let navigator = navigator else { return }
        let coordinator = SelectModeCoordinator(navigator: navigator, settings: settings, store: store)
        coordinator.start()
        
    }
    
    private func selectSinger(settings: Settings) {
        guard let store = store else { return }
        guard let navigator = navigator else { return }
        let coordinator = SelectSingerCoordinator(navigator: navigator, settings: settings, store: store)
        coordinator.start()
    }

    private func startGame(settings: Settings) {
        var gameDriver: RecitePoemCoordinator!
        
        guard let store = store else { return }
        guard let navigator = navigator else { return }
        switch settings.mode.reciteMode {
        case .normal:
            gameDriver = NormalModeCoordinator(navigator: navigator, settings: settings, store: store)
            gameDriver.start()
        case .nonstop:
            gameDriver = NonsotpModeCoordinator(navigator: navigator, settings: settings, store: store)
            gameDriver.start()
        case .beginner:
            gameDriver = BeginnerModeCoordinator(navigator: navigator, settings: settings, store: store)
            gameDriver.start()
        }
        guard let coordinator = gameDriver else { return }
        self.recitePoemCoordinator = coordinator
    }
    
    private func setSaveSettingsActionTo(screen: HomeViewController, settings: Settings ) {
        guard let store = store else { return }
        screen.saveSettingsAction = { [store, settings] in
            self.saveSettingsPermanently(settings, into: store)
        }
    }
    
    private func openReciteSettings(settins: Settings) {
        guard let homeScreen = self.screen else { return }
        guard let store = store else { return }
        let coordinator = ReciteSettingsCoordinator(settings: settins, fromScreen: homeScreen, store: store)
        coordinator.start()
        self.reciteSettingsCoordinator = coordinator
    }
    
    private func openHelpList() {
        guard let navigator = navigator else { return }

        let coordinator = HelpListCoordinator(navigator: navigator)
        coordinator.start()
        self.helpListCoordinator = coordinator
    }
    
    private func openMemorizeTimer() {
        guard let navigator = navigator else { return }

        let coordinator = MemorizeTimerCoordinator(navigator: navigator)
        coordinator.start()
        self.memorizeTimerCoordinator = coordinator
    }
}

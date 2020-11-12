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
        let store = StoreManager()
        self.store = store
        let settings = setUpSettings()
        self.settings = settings
        let homeScreen = HomeViewController(settings: settings)
        self.screen = homeScreen
        let navigator = UINavigationController(rootViewController: homeScreen)
        setUpNavigationController(navigator)
        self.navigator = navigator
        
        window.rootViewController = navigator
        window.makeKeyAndVisible()

        setActions(in: homeScreen, settings: settings, store: store, navigator: navigator)
        AudioPlayerFactory.shared.setupAudioSession()
    }

    private func setActions(in homeScreen: HomeViewController, settings: Settings, store: StoreManager, navigator: UINavigationController) {
        homeScreen.selectPoemAction = {[weak self, unowned settings, store, unowned navigator] in
            self?.selectPoem(settings: settings, store: store, navigator: navigator)
        }
        homeScreen.selectModeAction = {[weak self, unowned settings, store, unowned navigator] in
            self?.selectMode(settings: settings, store: store, navigator: navigator)
        }
        homeScreen.selectSingerAction = {[weak self, unowned settings, store, unowned navigator] in
            self?.selectSinger(settings: settings, store: store, navigator: navigator)
        }
        homeScreen.startGameAction = {[weak self, unowned settings, store, unowned navigator] in
            self?.startGame(settings: settings, store: store, navigator: navigator)
        }
        homeScreen.reciteSettingsAction = { [weak self, unowned settings, store] in
            self?.openReciteSettings(from: homeScreen, settins: settings, store: store)
        }
        homeScreen.helpActioh = { [weak self, unowned navigator] in
            self?.openHelpList(navigator: navigator)
        }
        homeScreen.memorizeTimerAction = { [weak self, unowned navigator] in
            self?.openMemorizeTimer(navigator: navigator)
        }
        setSaveSettingsActionTo(screen: homeScreen, settings: settings, store: store)
    }
        
    private func selectPoem(settings: Settings, store: StoreManager, navigator: UINavigationController) {
        let coordinator = PoemPickerCoordinator(navigator: navigator, settings: settings, store: store)
        coordinator.start()
        self.poemPickerCoordinator = coordinator
    }
    
    private func selectMode(settings: Settings, store: StoreManager, navigator: UINavigationController) {
        let coordinator = SelectModeCoordinator(navigator: navigator, settings: settings, store: store)
        coordinator.start()
        
    }
    
    private func selectSinger(settings: Settings, store: StoreManager, navigator: UINavigationController) {
        let coordinator = SelectSingerCoordinator(navigator: navigator, settings: settings, store: store)
        coordinator.start()
    }

    private func startGame(settings: Settings, store: StoreManager, navigator: UINavigationController) {
        var gameDriver: RecitePoemCoordinator!
        
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
    
    private func setSaveSettingsActionTo(screen: HomeViewController, settings: Settings, store: StoreManager) {
        screen.saveSettingsAction = { [store, settings] in
            self.saveSettingsPermanently(settings, into: store)
        }
    }
    
    private func openReciteSettings(from screen: UIViewController, settins: Settings, store: StoreManager) {
        let coordinator = ReciteSettingsCoordinator(settings: settins, fromScreen: screen, store: store)
        coordinator.start()
        self.reciteSettingsCoordinator = coordinator
    }
    
    private func openHelpList(navigator: UINavigationController) {
        let coordinator = HelpListCoordinator(navigator: navigator)
        coordinator.start()
        self.helpListCoordinator = coordinator
    }
    
    private func openMemorizeTimer(navigator: UINavigationController) {
        let coordinator = MemorizeTimerCoordinator(navigator: navigator)
        coordinator.start()
        self.memorizeTimerCoordinator = coordinator
    }
}

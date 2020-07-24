//
//  MainCoordinator.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/04/21.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator, SaveSettings, HandleNavigator {
    var store: StoreManager?
    var screen: UIViewController?    
    var navigator = UINavigationController()
//    internal var  store = StoreManager()
    internal var settings: Settings?
    internal let env = Environment()
    private var recitePoemCoordinator: RecitePoemCoordinator!
    private var reciteSettingsCoordinator: ReciteSettingsCoordinator!
    private var poemPickerCoordinator: PoemPickerCoordinator!
    private var helpListCoordinator: HelpListCoordinator!

    func start() {
        self.store = StoreManager()
        self.settings = setUpSettings()
        guard let settings = settings else { return }
        let homeScreen = HomeViewController(settings: settings)
        setUpNavigationController(navigator)
        navigator.pushViewController(homeScreen, animated: false)
        
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
        setSaveSettingsActionTo(screen: homeScreen, settings: settings)
        AudioPlayerFactory.shared.setupAudioSession()
        self.screen = homeScreen
    }
    
//    private func setUpNavigationController() {
//        navigator.interactivePopGestureRecognizer?.isEnabled = false
//        navigator.navigationBar.topItem?.prompt = "百首読み上げ"
//        navigator.navigationBar.barTintColor = StandardColor.barTintColor
//    }
//
    private func selectPoem(settings: Settings) {
        guard let store = store else { return }
        let coordinator = PoemPickerCoordinator(navigator: navigator, settings: settings, store: store)
        coordinator.start()
        self.poemPickerCoordinator = coordinator
    }
    
    private func selectMode(settings: Settings) {
        guard let store = store else { return }
        let coordinator = SelectModeCoordinator(navigator: navigator, settings: settings, store: store)
        coordinator.start()
        
    }
    
    private func selectSinger(settings: Settings) {
        guard let store = store else { return }
        let coordinator = SelectSingerCoordinator(navigator: navigator, settings: settings, store: store)
        coordinator.start()
    }

    private func startGame(settings: Settings) {
        var gameDriver: RecitePoemCoordinator!
        
        guard let store = store else { return }
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
//            store.saveSettingsPermanently(settings)
//            do {
//                try store.save(value: settings, key: Settings.userDefaultKey)
//            } catch {
//                assertionFailure("SettingsデータのUserDefautへの保存に失敗しました。")
//            }
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
        let coordinator = HelpListCoordinator(navigator: navigator)
        coordinator.start()
        self.helpListCoordinator = coordinator
    }
}

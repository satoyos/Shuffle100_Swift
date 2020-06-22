//
//  MainCoordinator.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/04/21.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigator = UINavigationController()
    internal let store = StoreManager()
    internal let env = Environment()
    private var recitePoemCoordinator: RecitePoemCoordinator!
    private var reciteSettingsCoordinator: ReciteSettingsCoordinator!
    private var poemPickerCoordinator: PoemPickerCoordinator!
    private var helpListCoordinator: HelpListCoordinator!
    private var homeScreen: HomeViewController?

    func start() {
        let settings = setUpSettings()
        let homeScreen = HomeViewController(settings: settings)
        navigator.pushViewController(homeScreen as UIViewController, animated: false)
        setUpNavigationController()
        
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
        self.homeScreen = homeScreen
    }
    
    private func setUpNavigationController() {
        navigator.interactivePopGestureRecognizer?.isEnabled = false
        navigator.navigationBar.topItem?.prompt = "百首読み上げ"
        navigator.navigationBar.barTintColor = StandardColor.barTintColor
    }
    
    private func selectPoem(settings: Settings) {
        let coordinator = PoemPickerCoordinator(navigator: navigator, settings: settings, store: store)
        coordinator.start()
        self.poemPickerCoordinator = coordinator
    }
    
    private func selectMode(settings: Settings) {
        let coordinator = SelectModeCoordinator(navigator: navigator, settings: settings, store: store)
        coordinator.start()
        
    }
    
    private func selectSinger(settings: Settings) {
        let coordinator = SelectSingerCoordinator(navigator: navigator, settings: settings, store: store)
        coordinator.start()
    }

    private func startGame(settings: Settings) {
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
    
    private func setSaveSettingsActionTo(screen: HomeViewController, settings: Settings ) {
        screen.saveSettingsAction = { [store, settings] in
            do {
                try store.save(value: settings, key: Settings.userDefaultKey)
            } catch {
                assertionFailure("SettingsデータのUserDefautへの保存に失敗しました。")
            }
        }
    }
    
    private func openReciteSettings(settins: Settings) {
        guard let homeScreen = self.homeScreen else { return }
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

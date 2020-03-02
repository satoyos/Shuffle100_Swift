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
    var recitePoemCoordinator: RecitePoemCoordinator!
    let store = StoreManager()
    let env = Environment()
    var homeScreen: HomeViewController?

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
            gameDriver = NormalModeCoordinator(navigator: navigator, settings: settings)
            gameDriver.start()
        case .nonstop:
            gameDriver = NonsotpModeCoordinator(navigator: navigator, settings: settings)
            gameDriver.start()
        default:
            assertionFailure("Not implemented yet!!")
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
        let coordinator = ReciteSettingsCoordinator(settings: settins, fromScreen: homeScreen)
        coordinator.start()
    }
}

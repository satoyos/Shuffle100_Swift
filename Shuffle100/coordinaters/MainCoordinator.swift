//
//  MainCoordinator.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/04/21.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigator = UINavigationController()

    func start() {
        let settings = Settings()
        if let gameSettings = tryLoadLegacyGameSettings() {
            if !nowTesting() {
                initSettings(settings, with: gameSettings)
            }
        }
        if let recitingSettings = tryLoadLegacyRecitingSettings() {
            if !nowTesting() {
                initSettings(settings, with: recitingSettings)
            }
        }
        let homeScreen = HomeViewController(settings: settings)
        navigator.pushViewController(homeScreen as UIViewController, animated: false)
        setUpNavigationController()
        
        homeScreen.selectPoemAction = {[weak self, unowned settings] in
            self?.selectPoem(settings: settings)
        }
        
        homeScreen.selectModeAction = {[weak self, unowned settings] in
            self?.selectMode(settings: settings)
        }
        
        homeScreen.startGameAction = {[weak self, unowned settings] in
            self?.startGame(settings: settings)
        }
    }
    
    private func setUpNavigationController() {
        navigator.interactivePopGestureRecognizer?.isEnabled = false
        navigator.navigationBar.topItem?.prompt = "百首読み上げ"
        navigator.navigationBar.barTintColor = Color.natsumushi.UIColor
    }
    
    private func selectPoem(settings: Settings) {
        let coordinator = PoemPickerCoordinator(navigator: navigator, settings: settings)
        coordinator.start()
    }
    
    
    private func selectMode(settings: Settings) {
        let coordinator = SelectModeCoordinator(navigator: navigator, settings: settings)
        coordinator.start()
        
    }

    private func startGame(settings: Settings) {
//        navigator.pushViewController(RecitePoemViewController(), animated: true)
        let coordinator = RecitePoemCoordinator(navigator: navigator, settings: settings)
        coordinator.start()
    }
    
    private func tryLoadLegacyRecitingSettings() -> RecitingSettings? {
        if let loadedSettings = RecitingSettings.salvageDataFromUserDefaults() {
            print("+++ Success loading Legacy Data")
            loadedSettings.debugPrint()
            return loadedSettings
        } else {
            return nil
        }
    }
    
    private func tryLoadLegacyGameSettings() -> GameSettings? {
        if let gameSettings = GameSettings.salvageDataFromUserDefaults() {
            print("+++ Success loading legacy GameSettings")
            gameSettings.debugPrint()
            return gameSettings
        } else {
            return nil
        }
    }
    
    private func initSettings(_ settings: Settings, with gameSettings: GameSettings) {
        settings.fakeMode = gameSettings.fake_flg
        settings.reciteMode = .normal // still fail loading legacy saved symbol data
        settings.state100 = LegacyDataConverter.state100FromGameSettings(gameSettings)
        settings.savedFudaSets = LegacyDataConverter.savedFudaSetsFromGameSettings(gameSettings)
    }
    
    private func initSettings(_ settings: Settings, with recitingSettings: RecitingSettings) {
        settings.recitingConfig = LegacyDataConverter.convertRecitingSettings(recitingSettings)
    }
    
    private func nowTesting() -> Bool {
        let testing = (ProcessInfo.processInfo.environment["IS_TESTING"] == "1")
        return testing
    }
}
